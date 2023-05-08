
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

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  // String _platformVersion =
  //     '${Platform.operatingSystem} ${Platform.operatingSystemVersion}';
  NFCAvailability _availability = NFCAvailability.not_supported;
  NFCTag? _tag;
  String? _result, _writeResult;
  TabController? _tabController;
  List<ndef.NDEFRecord>? _records;

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _tabController = new TabController(length: 2, vsync: this);
    _records = [];
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    NFCAvailability availability;
    try {
      availability = await FlutterNfcKit.nfcAvailability;
    } on PlatformException {
      availability = NFCAvailability.not_supported;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
      _availability = availability;
    });
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

  @override
  Widget build(BuildContext context) {
    return AlertScreen(
      child: Scaffold(
        appBar: AppBar(
            title: const Text('NFC Demo Flutter'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(child: Text('Read', style: context.titleMedium,)),
                Tab(child: Text('Write', style: context.titleMedium,)),
              ],
              controller: _tabController,
            )),
        body: TabBarView(controller: _tabController, children: <Widget>[
          Scrollbar(
              child: SingleChildScrollView(
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('NFC: $_availability'),
                            ElevatedButton(
                              onPressed: () async {
                                try {
                                  NFCTag tag = await FlutterNfcKit.poll();
                                  setState(() {
                                    _tag = tag;
                                  });
                                  await FlutterNfcKit.setIosAlertMessage(
                                      "working on it...");
                                  if (tag.standard == "ISO 14443-4 (Type B)") {
                                    String result1 =
                                    await FlutterNfcKit.transceive("00B0950000");
                                    String result2 = await FlutterNfcKit.transceive(
                                        "00A4040009A00000000386980701");
                                    setState(() {
                                      _result = '1: $result1\n2: $result2\n';
                                    });
                                  } else if (tag.type == NFCTagType.iso18092) {
                                    String result1 =
                                    await FlutterNfcKit.transceive("060080080100");
                                    setState(() {
                                      _result = '1: $result1\n';
                                    });
                                  } else if (tag.type == NFCTagType.mifare_ultralight ||
                                      tag.type == NFCTagType.mifare_classic) {
                                    var ndefRecords = await FlutterNfcKit.readNDEFRecords();
                                    var ndefString = ndefRecords
                                        .map((r) => r.toString())
                                        .reduce((value, element) => value + "\n" + element);
                                    setState(() {
                                      _result = '1: $ndefString\n';
                                    });
                                  }
                                } catch (e) {
                                  setState(() {
                                    _result = 'error: $e';
                                  });
                                }

                                // Pretend that we are working
                                sleep(new Duration(seconds: 1));
                                await FlutterNfcKit.finish(iosAlertMessage: "Finished!");
                              },
                              child: Text('Start polling'),
                            ),
                            _tag != null
                                ? Text(
                                'ID: ${_tag?.id}\nStandard: ${_tag?.standard}\nType: ${_tag?.type}\nATQA: ${_tag?.atqa}\nSAK: ${_tag?.sak}\nHistorical Bytes: ${_tag?.historicalBytes}\nProtocol Info: ${_tag?.protocolInfo}\nApplication Data: ${_tag?.applicationData}\nHigher Layer Response: ${_tag?.hiLayerResponse}\nManufacturer: ${_tag?.manufacturer}\nSystem Code: ${_tag?.systemCode}\nDSF ID: ${_tag?.dsfId}\nNDEF Available: ${_tag?.ndefAvailable}\nNDEF Type: ${_tag?.ndefType}\nNDEF Writable: ${_tag?.ndefWritable}\nNDEF Can Make Read Only: ${_tag?.ndefCanMakeReadOnly}\nNDEF Capacity: ${_tag?.ndefCapacity}\n\n Transceive Result:\n$_result')
                                : Text('No tag polled yet.')
                          ])))),
          Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () async {
                          if (_records!.length != 0) {
                            try {
                              NFCTag tag = await FlutterNfcKit.poll();
                              setState(() {
                                _tag = tag;
                              });
                              if (tag.type == NFCTagType.mifare_ultralight ||
                                  tag.type == NFCTagType.mifare_classic) {
                                await FlutterNfcKit.writeNDEFRecords(_records!);
                                setState(() {
                                  _writeResult = 'OK';
                                });
                              } else {
                                setState(() {
                                  _writeResult =
                                  'error: NDEF not supported: ${tag.type}';
                                });
                              }
                            } catch (e, stacktrace) {
                              setState(() {
                                _writeResult = 'error: $e';
                              });
                              print(stacktrace);
                            } finally {
                              await FlutterNfcKit.finish();
                            }
                          } else {
                            setState(() {
                              _writeResult = 'error: No record';
                            });
                          }
                        },
                        child: Text("Start writing"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SimpleDialog(
                                    title: Text("Record Type"),
                                    children: <Widget>[
                                      SimpleDialogOption(
                                        child: Text("Text Record"),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          final result = await Navigator.push(
                                              context, MaterialPageRoute(
                                              builder: (context) {
                                                return TextRecordSetting();
                                              }));
                                          if (result != null) {
                                            if (result is ndef.TextRecord) {
                                              setState(() {
                                                _records!.add(result);
                                              });
                                            }
                                          }
                                        },
                                      ),
                                      SimpleDialogOption(
                                        child: Text("Uri Record"),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          final result = await Navigator.push(
                                              context, MaterialPageRoute(
                                              builder: (context) {
                                                return UriRecordSetting();
                                              }));
                                          if (result != null) {
                                            if (result is ndef.UriRecord) {
                                              setState(() {
                                                _records!.add(result);
                                              });
                                            }
                                          }
                                        },
                                      ),
                                      SimpleDialogOption(
                                        child: Text("Raw Record"),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          final result = await Navigator.push(
                                              context, MaterialPageRoute(
                                              builder: (context) {
                                                return NDEFRecordSetting();
                                              }));
                                          if (result != null) {
                                            if (result is ndef.NDEFRecord) {
                                              setState(() {
                                                _records!.add(result);
                                              });
                                            }
                                          }
                                        },
                                      ),
                                    ]);
                              });
                        },
                        child: Text("Add record"),
                      )
                    ],
                  ),
                  Text('Result:$_writeResult'),
                  if (_records != null) ...[ Expanded(
                    flex: 1,
                    child: ListView(
                        shrinkWrap: true,
                        children: List<Widget>.generate(
                            _records!.length,
                                (index) => GestureDetector(
                              child: Text(
                                  'id:${_records![index].id?.toHexString()}\ntnf:${_records![index].tnf}\ntype:${_records![index].type?.toHexString()}\npayload:${_records![index].payload!.toHexString()}\n'),
                              onTap: () async {
                                final result = await Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return NDEFRecordSetting(
                                          record: _records![index]);
                                    }));
                                if (result != null) {
                                  if (result is ndef.NDEFRecord) {
                                    setState(() {
                                      _records![index] = result;
                                    });
                                  } else if (result is String &&
                                      result == "Delete") {
                                    _records!.removeAt(index);
                                  }
                                }
                              },
                            ))),
                  )],
                ]),
          )
        ]),
      ),

    );
  }

  Widget _buildMainScreen() {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
              final languageId = state.selectedLanguage.languageId == 1 ? 2 : 1;
              return TextButton(
                onPressed: () {
                  _languageCubit.changeLanguage(languageId);
                },
                child: Text(
                  languageId == 1 ? 'Fi' : 'En',
                  style: context.titleSmall?.copyWith(fontSize: 18),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image.asset('assets/images/logo2023.jpg', alignment: Alignment.center),
          ),
          Text(
            'urheiluhallit_app_deprecation_msg_title'.tt(context),
            style: context.titleLarge?.copyWith(fontSize: 24.0),
          ),
          Text(
            'urheiluhallit_app_deprecation_msg_body'.tt(context),
            style: context.bodySmall?.copyWith(fontSize: 18.0),
          ),
          const _LinkWidget().paddingOnly(bottom: 16.0),
        ],
      ).paddingSymmetric(horizontal: 32.0, vertical: 16.0),
    );
  }
}

class _LinkWidget extends StatelessWidget {
  const _LinkWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 100);
    // return (SizerUtil.deviceType == DeviceType.tablet)
    //     ? const SizedBox(height: 100)
        // : GestureDetector(
            // onTap: () {
            //   if (Platform.isAndroid || Platform.isIOS) {
            //     final appId = Platform.isAndroid ? 'fi.enkora.onthemove' : '1591569704';
            //     final url = Uri.parse(
            //       Platform.isAndroid ? 'market://details?id=$appId' : 'https://apps.apple.com/app/id$appId',
            //     );
            //     launchUrl(url, mode: LaunchMode.externalApplication);
            //   }
            // },
            // child: Column(
            //   children: [
            //     Align(
            //       alignment: Alignment.centerLeft,
            //       child: Text(
            //         'Powered by'.tt(context),
            //         style: context.bodySmall?.copyWith(fontSize: 24.0),
            //       ),
            //     ).paddingOnly(left: 10.w),
            //     Image.asset('assets/images/enkora_logo.png', scale: 4, alignment: Alignment.center),
            //     Align(
            //       alignment: Alignment.centerRight,
            //       child: Text(
            //         'OnTheMove'.tt(context),
            //         style: context.bodySmall?.copyWith(fontSize: 24.0),
            //       ),
            //     ).paddingOnly(right: 10.w, bottom: 16.0),
            //     BlocBuilder<LanguageCubit, LanguageState>(
            //       builder: (context, state) {
            //         if (Platform.isAndroid) {
            //           final imageName =
            //               state.selectedLanguage.languageId == 1 ? 'google-play-badge' : 'google-play-badge-fi';
            //           return Image.asset('assets/images/$imageName.png', alignment: Alignment.center, width: 70.w);
            //         } else {
            //           final imageName = state.selectedLanguage.languageId == 1 ? 'appstore-badge' : 'appstore-badge-fi';
            //           return SvgPicture.asset('assets/images/$imageName.svg', alignment: Alignment.center, width: 60.w);
            //         }
            //       },
            //     ),
            //   ],
            // ).paddingSymmetric(horizontal: 4.w),
          // );
  }
}
