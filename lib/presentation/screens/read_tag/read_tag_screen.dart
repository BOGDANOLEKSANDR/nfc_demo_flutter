import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nfc_demo/common_libs.dart';
import 'package:nfc_demo/logic/language/language_cubit.dart';
import 'package:nfc_demo/presentation/alert/alert_screen.dart';
import 'package:nfc_demo/presentation/screens/read_tag/read_tag_cubit.dart';
import 'package:nfc_demo/presentation/screens/record-setting/raw_record_setting.dart';
import 'package:nfc_demo/presentation/screens/record-setting/text_record_setting.dart';
import 'package:nfc_demo/presentation/screens/record-setting/uri_record_setting.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'dart:async';
import 'dart:io' show sleep;
import 'dart:js' as js;

import '../../widgets/button_back.dart';
import 'read_tag_state.dart';

class ReadTagScreen extends StatefulWidget {
  const ReadTagScreen({Key? key}) : super(key: key);

  @override
  State<ReadTagScreen> createState() => _ReadTagScreenState();
}

class _ReadTagScreenState extends State<ReadTagScreen> with SingleTickerProviderStateMixin {
  late ReadTagCubit _readTagCubit;
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
    _readTagCubit.close();
    super.dispose();
  }

  @override
  void initState() {
    _readTagCubit = getIt();
    _readTagCubit.startNFCScan();
    super.initState();
  }

  // late LanguageCubit _languageCubit;

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

  // bool isNDEFReaderSupported() {
  //   return js.context.hasProperty('NDEFReader');
  // }

  // void startNFCScan() async {
  //   try {
  //     final ndef = js.JsObject(js.context['NDEFReader']);
  //     await ndef.callMethod('scan');
  //     setState(() {
  //       statusMsg += "> Scan started\n";
  //     });
  //     ndef.callMethod('addEventListener', ['readingerror', (event) {
  //       setState(() {
  //         statusMsg += "Argh! Cannot read data from the NFC tag. Try another one?\n";
  //       });
  //     }]);
  //     ndef.callMethod('addEventListener', ['reading', (event) {
  //       final message = event['message'];
  //       final serialNumber = event['serialNumber'];
  //       final records = message['records'];
  //       setState(() {
  //         statusMsg += "> Serial Number: $serialNumber \n";
  //         statusMsg += "> Records: (${records.length}) \n";
  //       });
  //       // statusMsg += "> ${message['records']} \n";
  //       for (final record in records) {
  //         printNDEFRecord(record);
  //       }
  //     }]);
  //   } catch (error) {
  //     setState(() {
  //       statusMsg += 'Argh! $error \n';
  //     });
  //   }
  // }

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

  // void printNDEFRecord(ndefRecord) {
  //   final recordType = ndefRecord['recordType'];
  //   final mediaType = ndefRecord['mediaType'];
  //   final data = ndefRecord['data'];
  //   final encoding = ndefRecord['encoding'];
  //   final lang = ndefRecord['lang'];
  //
  //   setState(() {
  //     statusMsg += 'Record Type: $recordType \n';
  //     statusMsg += 'Media Type: $mediaType \n';
  //     statusMsg += 'Data: $data \n';
  //     statusMsg += 'Encoding: $encoding \n';
  //     statusMsg += 'Language: $lang \n';
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _readTagCubit,
      child: Scaffold(
        appBar: AppBar(title: Text('Read tag', style: context.headlineSmall,), leading: const ButtonBack()),
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
            child: BlocBuilder<ReadTagCubit, ReadTagState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text('Nfc Demo', style: context.titleMedium),
                    const SizedBox(height: 16.0),
                    if (!context.read<ReadTagCubit>().isNDEFReaderSupported()) ...[
                      Text('Web NFC is not available. Use Chrome on Android.',
                          style: context.bodySmall?.copyWith(color: AppColor.error)),
                    ],
                    // if (isNDEFReaderSupported()) ...[
                    //   TextButton(
                    //     style: ButtonStyle(
                    //       foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    //     ),
                    //     onPressed: () {
                    //       startNFCScan();
                    //     },
                    //     child: Text('Start scan'),
                    //   )
                    // ],
                    Text(statusMsg, style: context.bodySmall),
                  ],
                );
              },
            ),
          ).paddingSymmetric(horizontal: 16.0, vertical: 8.0),
        ),
      ),
    );
  }

}
