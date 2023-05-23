import 'dart:js';

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

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  String statusMsg = '';
  // String _platformVersion =
  //     '${Platform.operatingSystem} ${Platform.operatingSystemVersion}';
  // NFCAvailability _availability = NFCAvailability.not_supported;
  // NFCTag? _tag;
  // String? _result, _writeResult;
  // TabController? _tabController;
  // List<ndef.NDEFRecord>? _records;

  @override
  void dispose() {
    // _tabController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  late LanguageCubit _languageCubit;

  // @override
  // void initState() {
  //   super.initState();
  //   _languageCubit = getIt();
  // }
  //
  // @override
  // void dispose() {
  //   _languageCubit.close();
  //   super.dispose();
  // }

  bool isNDEFReaderSupported() {
    return js.context.hasProperty('NDEFReader');
  }


  void startNFCScan() {
    final ndef = JsObject(context['NDEFReader']);
    ndef.callMethod('scan').then((_) {
      setState(() {
        statusMsg += "> Scan started\n";
      });
      ndef['onreadingerror'] = (event) {
        setState(() {
          statusMsg += "Argh! Cannot read data from the NFC tag. Try another one?\n";
        });
      };
      ndef['onreading'] = (event) {
        final message = event['message'];
        final serialNumber = event['serialNumber'];
        final records = message['records'];
        setState(() {
          statusMsg += "> Serial Number: $serialNumber \n";
          statusMsg += "> Records: (${records.length}) \n";
        });
        // statusMsg += "> ${message['records']} \n";
        for (final record in records) {
          printNDEFRecord(record);
        }
      };
    }).catchError((error) {
      setState(() {
        statusMsg += 'Argh! $error \n';
      });
    });
  }



  // void startNFCScan() async {
  //   try {
  //     final ndefConstructor = js.context['NDEFReader'];
  //     final ndefInstance = js.JsObject(ndefConstructor);
  //
  //     await ndefInstance.callMethod('scan');
  //
  //     setState(() {
  //       statusMsg += "> Scan started\n";
  //     });
  //
  //     ndefInstance.callMethod('addEventListener', [
  //       'readingerror',
  //       js.allowInterop((event) {
  //         setState(() {
  //           statusMsg += "Argh! Cannot read data from the NFC tag. Try another one?\n";
  //         });
  //       }),
  //     ]);
  //
  //     ndefInstance.callMethod('addEventListener', [
  //       'reading',
  //       js.allowInterop((event) {
  //         final message = event['message'];
  //         final serialNumber = event['serialNumber'];
  //         final records = message['records'];
  //         setState(() {
  //           statusMsg += "> Serial Number: $serialNumber \n";
  //           statusMsg += "> Records: (${records.length}) \n";
  //         });
  //           // statusMsg += "> ${message['records']} \n";
  //           for (final record in records) {
  //             printNDEFRecord(record);
  //           }
  //
  //
  //         // log("> Serial Number: $serialNumber");
  //         // log("> Records: (${message['records'].length})");
  //       }),
  //     ]);
  //   } catch (error) {
  //     setState(() {
  //       statusMsg += 'Argh! $error \n';
  //     });
  //     // log("Argh! $error");
  //   }
  // }

  void printNDEFRecord(ndefRecord) {
    final recordType = ndefRecord['recordType'];
    final mediaType = ndefRecord['mediaType'];
    final data = ndefRecord['data'];
    final encoding = ndefRecord['encoding'];
    final lang = ndefRecord['lang'];

    setState(() {
    statusMsg += 'Record Type: $recordType \n';
    statusMsg += 'Media Type: $mediaType \n';
    statusMsg += 'Data: $data \n';
    statusMsg += 'Encoding: $encoding \n';
    statusMsg += 'Language: $lang \n';
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertScreen(
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            context.brightness == Brightness.light
                ? 'assets/images/enkora_logo.png'
                : 'assets/images/enkora_logo_dark.png',
            scale: 6.0,
            alignment: Alignment.bottomLeft,
          ),
          titleSpacing: 0,
          bottom: const PreferredSize(child: SizedBox.shrink(), preferredSize: Size.fromHeight(8.0)),
        ),
        // appBar: AppBar(
        //     title: const Text('NFC Demo'),
        //     bottom: TabBar(
        //       tabs: <Widget>[
        //         Tab(child: Text('Read', style: context.titleMedium,)),
        //         Tab(child: Text('Write', style: context.titleMedium,)),
        //       ],
        //       controller: _tabController,
        //     )),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nfc Demo', style: context.titleMedium),
                const SizedBox(height: 16.0),
                if (!isNDEFReaderSupported()) ...[
                  Text('Web NFC is not available. Use Chrome on Android.', style: context.bodySmall?.copyWith(color: AppColor.error)),
                ],
                if (isNDEFReaderSupported()) ...[
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () { startNFCScan();},
                    child: Text('Start scan'),
                  )
                ],
                Text(statusMsg, style: context.bodySmall),
              ],
            ),
          ).paddingSymmetric(horizontal: 16.0, vertical: 8.0),
        ),
      ),
    );
  }

  // Widget _buildMainScreen() {
  //   return Scaffold(
  //     appBar: AppBar(
  //       actions: [
  //         BlocBuilder<LanguageCubit, LanguageState>(
  //           builder: (context, state) {
  //             final languageId = state.selectedLanguage.languageId == 1 ? 2 : 1;
  //             return TextButton(
  //               onPressed: () {
  //                 _languageCubit.changeLanguage(languageId);
  //               },
  //               child: Text(
  //                 languageId == 1 ? 'Fi' : 'En',
  //                 style: context.titleSmall?.copyWith(fontSize: 18),
  //               ),
  //             );
  //           },
  //         ),
  //       ],
  //     ),
  //     body: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Center(
  //           child: Image.asset('assets/images/logo2023.jpg', alignment: Alignment.center),
  //         ),
  //         Text(
  //           'urheiluhallit_app_deprecation_msg_title'.tt(context),
  //           style: context.titleLarge?.copyWith(fontSize: 24.0),
  //         ),
  //         Text(
  //           'urheiluhallit_app_deprecation_msg_body'.tt(context),
  //           style: context.bodySmall?.copyWith(fontSize: 18.0),
  //         ),
  //         const _LinkWidget().paddingOnly(bottom: 16.0),
  //       ],
  //     ).paddingSymmetric(horizontal: 32.0, vertical: 16.0),
  //   );
  // }
}

// class _LinkWidget extends StatelessWidget {
//   const _LinkWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const SizedBox(height: 100);
//     // return (SizerUtil.deviceType == DeviceType.tablet)
//     //     ? const SizedBox(height: 100)
//     // : GestureDetector(
//     // onTap: () {
//     //   if (Platform.isAndroid || Platform.isIOS) {
//     //     final appId = Platform.isAndroid ? 'fi.enkora.onthemove' : '1591569704';
//     //     final url = Uri.parse(
//     //       Platform.isAndroid ? 'market://details?id=$appId' : 'https://apps.apple.com/app/id$appId',
//     //     );
//     //     launchUrl(url, mode: LaunchMode.externalApplication);
//     //   }
//     // },
//     // child: Column(
//     //   children: [
//     //     Align(
//     //       alignment: Alignment.centerLeft,
//     //       child: Text(
//     //         'Powered by'.tt(context),
//     //         style: context.bodySmall?.copyWith(fontSize: 24.0),
//     //       ),
//     //     ).paddingOnly(left: 10.w),
//     //     Image.asset('assets/images/enkora_logo.png', scale: 4, alignment: Alignment.center),
//     //     Align(
//     //       alignment: Alignment.centerRight,
//     //       child: Text(
//     //         'OnTheMove'.tt(context),
//     //         style: context.bodySmall?.copyWith(fontSize: 24.0),
//     //       ),
//     //     ).paddingOnly(right: 10.w, bottom: 16.0),
//     //     BlocBuilder<LanguageCubit, LanguageState>(
//     //       builder: (context, state) {
//     //         if (Platform.isAndroid) {
//     //           final imageName =
//     //               state.selectedLanguage.languageId == 1 ? 'google-play-badge' : 'google-play-badge-fi';
//     //           return Image.asset('assets/images/$imageName.png', alignment: Alignment.center, width: 70.w);
//     //         } else {
//     //           final imageName = state.selectedLanguage.languageId == 1 ? 'appstore-badge' : 'appstore-badge-fi';
//     //           return SvgPicture.asset('assets/images/$imageName.svg', alignment: Alignment.center, width: 60.w);
//     //         }
//     //       },
//     //     ),
//     //   ],
//     // ).paddingSymmetric(horizontal: 4.w),
//     // );
//   }
// }
