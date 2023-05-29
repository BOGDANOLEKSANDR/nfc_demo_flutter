import 'dart:convert';
import 'dart:io';
import 'package:convert/convert.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nfc_demo/common_libs.dart';
import 'dart:js' as js;

import 'read_tag_state.dart';

class ReadTagCubit extends Cubit<ReadTagState> {
  var  statusMsg = "> Scan started\n";
  ReadTagCubit() : super(ReadTagState.initial());

  void startNFCScan() async {
    if (!isNDEFReaderSupported()) return;

    try {
      final ndef = js.JsObject(js.context['NDEFReader']);
      await ndef.callMethod('scan');

      emit(state.copyWith(details: statusMsg, status: CallStatus.loading));

      // setState(() {

      // });
      ndef.callMethod('addEventListener', ['readingerror', (event) {
        // setState(() {
          statusMsg += "Argh! Cannot read data from the NFC tag. Try another one?\n";
          emit(state.copyWith(details: statusMsg));
        // });
      }]);
      ndef.callMethod('addEventListener', ['reading', (event) {
        final message = event['message'];
        final serialNumber = event['serialNumber'];
        final records = message['records'];
        // setState(() {

        String reversedMac = reverseSerialNumber(serialNumber);
        int transformedNumber = transformToNumber(reversedMac);
          statusMsg += "> Serial Number: $serialNumber \n";
          statusMsg += "> Reversed: $reversedMac \n";
          statusMsg += "> Transformed Number: $transformedNumber \n";


          // statusMsg += "> Records: (${records.length}) \n";
        // });
        // statusMsg += "> ${message['records']} \n";
        // for (final record in records) {
        //   printNDEFRecord(record);
        // }
        emit(state.copyWith(details: statusMsg));
      }]);
    } catch (error) {
      // setState(() {
        statusMsg += 'Argh! $error \n';
        emit(state.copyWith(details: statusMsg));
      // });
    }
  }

  String reverseSerialNumber(String serialNumber) {
    List<String> parts = serialNumber.split(':');
    List<String> reversedParts = parts.reversed.toList();
    String reversedSerial = reversedParts.join(':');
    return reversedSerial;
  }

  int transformToNumber(String reversedSerial) {
    int transformedNumber = int.parse(reversedSerial.replaceAll(':', ''), radix: 16);
    return transformedNumber;
  }

  bool isNDEFReaderSupported() {
    return js.context.hasProperty('NDEFReader');
  }


}
