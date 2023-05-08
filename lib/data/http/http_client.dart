import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:nfc_demo/common_libs.dart';
import 'package:nfc_demo/core/exceptions/app_exception.dart';

class LoggingInterceptor implements InterceptorContract {
  static final _log = getLogger();

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    _log.v(data);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    _log.v(data.toString());
    return data;
  }
}

class HttpClient {
  final http.Client _http;
  static const int timeoutDuration = 40;

  HttpClient(http.Client httpClient) : _http = httpClient;

  Stream<dynamic> post({
    String? baseUrl = '',
    String? endpoint = '',
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    dynamic body,
  }) {
    final uri = Uri.parse('${baseUrl!}${endpoint!}').replace(queryParameters: queryParameters);
    return Stream.fromFuture(
      _http
          .post(uri, headers: headers, body: body, encoding: Encoding.getByName("utf-8"))
          .timeout(const Duration(seconds: timeoutDuration)),
    ).map(
      (response) => _handleData(response),
    );
  }

  static dynamic _handleData(http.Response response) {
    Map<String, dynamic> data = {};
    try {
      data = jsonDecode(response.body);
    } on Exception catch (e) {
      throw AppException(response.body);
    }
    if (data['user_errors'] != null) {
      if (data['user_errors'] is List && (data['user_errors'] as List).isNotEmpty) {
        throw AppException(data['user_errors'][0]);
      }

      throw AppException(data['user_errors'].toString());
    }
    if (data['errors'] != null) {
      if (data['errors'] is List && (data['errors'] as List).isNotEmpty) {
        throw AppException(data['errors'][0]);
      } else if (data['errors'] is String) {
        throw AppException(data['errors'].toString());
      }
    }

    if (data['result'] != null && data['result'] is Map<String, dynamic> && data['result']['result'] == false) {
      if (data['result']['message'] != null) {
        throw AppException(data['result']['message']);
      } else {
        throw AppException('');
      }
    }

    return data['result'];
  }
}
