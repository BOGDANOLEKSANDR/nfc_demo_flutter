import 'dart:convert';

import 'package:nfc_demo/common_libs.dart';
import 'package:nfc_demo/data/http/http_client.dart';

class CallService {
  final HttpClient _http;
  final ConfigService _configService;

  CallService(
    HttpClient httpClient,
    ConfigService configService,
  )   : _http = httpClient,
        _configService = configService;

  Map<String, String>? get headers {
    return {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
  }

  Stream<T> make<T>(String? endpoint, {dynamic payload, String? appToken, onthemove = false}) {
    final String url = '${onthemove ? _configService.baseUrl : _configService.serviceUrl}call/';

    Map<String, String> body = {
      'input_format': 'json',
      'output_format': 'json',
      'device_type_id': '13',
      if (payload != null) 'content': json.encode(payload),
    };

    Map<String, String> queryParameters = {};

    return _http
        .post(
          baseUrl: url,
          endpoint: endpoint,
          headers: headers,
          queryParameters: queryParameters,
          body: body,
        )
        .map((response) => response as T);
  }
}
