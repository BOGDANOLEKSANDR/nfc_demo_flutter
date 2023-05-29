import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nfc_demo/common_libs.dart';
import 'package:nfc_demo/logic/language/language_cubit.dart';
import 'package:nfc_demo/presentation/alert/alert_screen.dart';
import 'package:nfc_demo/presentation/screens/record-setting/raw_record_setting.dart';
import 'package:nfc_demo/presentation/screens/record-setting/text_record_setting.dart';
import 'package:nfc_demo/presentation/screens/record-setting/uri_record_setting.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'dart:async';
import 'dart:io' show sleep;
import 'dart:js' as js;

import '../home/home_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertScreen(
      child: HomeScreen(),
    );

  }
}


