import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'constants.dart';

class AppConstants {
  // Fonts
  static TextStyle largeTitleTextStyle = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.bold,
    color: secondayColor,
  );
  static TextStyle titleTextStyle = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle bodyTextStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
  );
  static TextStyle bodySmallTextStyle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );
  // Colors
  static const Color primaryColor = Color(0xFF000080);
  static const Color primaryAlternativeColor = Color(0xff4525A2);

  static const Color secondayColor = Color(0xFF371E81);
  static const Color lightSecondayColor = Color(0xFFEFECF8);

  static const Color primaryColorLight = Color(0xFF65D48D);
  static const Color primaryColorVeryLight = Color.fromARGB(255, 226, 233, 240);
  static const Color black = Color(0xFF1F2C37);
  static const Color white = Color.fromARGB(255, 255, 255, 255);
  static const Color grey100 = Color(0xFFFAFAFA);
  static const Color grey200 = Color(0xFFF5F5F5);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9CA4AB);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey800 = Color(0xFF2b2b2c);
  static const Color grey900 = Color(0xFF515152);

  static const Color iconColor = Color(0xFF625F5F);
  static const Color grey700 = Color(0xFF000000);
  static const Color backgroundColor = Color(0xFFFDFDFD);
  static const Color lightTextColor = Color(0xFF2C2B2B);

  // Margins
  static const double smallMargin = 10.0;
  static const double mediumMargin = 16.0;
  static const double largeMargin = 24.0;
  // Font
  static const double xxSmall = 8.0;
  static const double xSmall = 10.0;
  static const double small = 12;
  static const double medium = 14.0;
  static const double large = 16.0;
  static const double xLarge = 18.0;
  static const double xxLarge = 20.0;
  static const double xxxLarge = 24.0;
  static const double xxxxLarge = 32.0;
  // Paddings
  static const EdgeInsets smallPadding = EdgeInsets.all(8.0);
  static const EdgeInsets mediumPadding = EdgeInsets.all(16.0);
  static const EdgeInsets largePadding = EdgeInsets.all(24.0);
  static const EdgeInsets bodyPadding = EdgeInsets.all(25.0);

  // Label Styles
  static const TextStyle labelTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static var timeout = Duration(seconds: time_out);
}
