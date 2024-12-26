import 'dart:convert';

import 'package:dh_flutter_v2/constants/app_theme.dart';
import 'package:dh_flutter_v2/utils/utils.dart';
import 'package:flutter/material.dart';
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

void showConfirmationDialog(
    {required BuildContext context,
    required String title,
    required String content,
    required Function() onConfirm,
    String? actionBtnText,
    Color? actionBtnColor}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppTheme.gray.shade600,
          ),
        ),
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        // Remove actionsPadding and actionsAlignment
        actions: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade300,
                  width: 0.5,
                ),
              ),
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade300,
                    width: 1,
                    thickness: 0.8,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: onConfirm,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        actionBtnText ?? "Confirm",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: actionBtnColor ?? AppTheme.info.shade600,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}
