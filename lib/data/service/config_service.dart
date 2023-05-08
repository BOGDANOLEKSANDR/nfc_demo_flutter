import 'package:flutter/foundation.dart';
import 'package:nfc_demo/core/constants/config.dart';

class ConfigService {
  String serviceUrl = '';
  String get baseUrl => kReleaseMode ? Config.prodUrl : Config.stagingUrl;
}
