import 'dart:convert';

import 'package:dh_flutter_v2/utils/utils.dart';
import 'package:flutter/services.dart';

class RestrictedInputFormatter extends TextInputFormatter {
  final RegExp _restrictedPattern;
  RestrictedInputFormatter(this._restrictedPattern);
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (_restrictedPattern.hasMatch(newValue.text)) {
      return oldValue;
    }
    return newValue;
  }
}

// Future<bool> isSecureDevice() async {
//   bool isDeviceRooted = await RootTester.isDeviceRooted;
//   final isRealDevice = await JailbreakRootDetection.instance.isRealDevice;
//   if (isDeviceRooted || isRealDevice == false) {
//     return false;
//   } else {
//     return true;
//   }
// }

void logger(String title, dynamic data) {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  String formattedJson = encoder.convert(data);
  Session().logSession(title, formattedJson);
}
