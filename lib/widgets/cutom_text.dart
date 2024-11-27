import 'package:dh/constants/app_constants.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool? centerText;
  const CustomText(
      {super.key,
      required this.title,
      this.fontSize,
      this.fontWeight,
      this.centerText,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: centerText == true ? TextAlign.center : null,
      style: TextStyle(
        fontSize: fontSize ?? 12,
        fontWeight: fontWeight ?? FontWeight.bold,
        overflow: TextOverflow.ellipsis,
        color: textColor ?? AppConstants.primaryColor,
      ),
    );
  }
}
