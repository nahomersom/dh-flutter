import 'package:flutter/material.dart';

class AppTheme {
  static const Color baseBlack = Color(0xFF000000);
  static const Color baseWhite = Color(0xFFFFFFFF);

  static const MaterialColor primary = MaterialColor(
    0xFF4525A2,
    <int, Color>{
      25: Color(0xFFF8F6FE),
      50: Color(0xFFEFECF8),
      100: Color(0xFFE0DAF1),
      200: Color(0xFFCEC5E7),
      300: Color(0xFFAFA0D8),
      400: Color(0xFF8B77C6),
      500: Color(0xFF684EB4),
      600: Color(0xFF4525A2),
      700: Color(0xFF371E81),
      800: Color(0xFF291661),
      900: Color(0xFF1B0E3E),
    },
  );

  static const MaterialColor gray = MaterialColor(
    0xFF525151,
    <int, Color>{
      25: Color(0xFFFCFCFC),
      50: Color(0xFFF2F2F2),
      100: Color(0xFFE3E3E3),
      200: Color(0xFFD7D6D6),
      300: Color(0xFFC0BFBF),
      400: Color(0xFF7D7C7C),
      500: Color(0xFF525151),
      600: Color(0xFF2C2B2B),
      700: Color(0xFF1C1C1C),
      800: Color(0xFF0F0F0F),
      900: Color(0xFF060606),
    },
  );

  static const MaterialColor success = MaterialColor(
    0xFF0A9952,
    <int, Color>{
      25: Color(0xFFF2FFF9),
      50: Color(0xFFD7FFEB),
      100: Color(0xFF7DFEB9),
      200: Color(0xFF44E790),
      300: Color(0xFF2FD181),
      400: Color(0xFF1DB469),
      500: Color(0xFF11A75C),
      600: Color(0xFF0A9952),
      700: Color(0xFF048746),
      800: Color(0xFF046A37),
      900: Color(0xFF02542B),
    },
  );

  static const MaterialColor info = MaterialColor(
    0xFF0A9952,
    <int, Color>{
      25: Color(0xFFF6F9FE),
      50: Color(0xFFE8F1FD),
      100: Color(0xFFD1E3FA),
      200: Color(0xFFBAD5F8),
      300: Color(0xFFA3C7F6),
      400: Color(0xFF76ABF1),
      500: Color(0xFF488FED),
      600: Color(0xFF1A73E8),
      700: Color(0xFF155CBA),
      800: Color(0xFF10458B),
      900: Color(0xFF082246),
    },
  );

  static const MaterialColor warning = MaterialColor(
    0xFFD8A800,
    <int, Color>{
      25: Color(0xFFFFF9DF),
      50: Color(0xFFFFF2C4),
      100: Color(0xFFFFE99D),
      200: Color(0xFFFFE176),
      300: Color(0xFFFFD84E),
      400: Color(0xFFFFD027),
      500: Color(0xFFFFC700),
      600: Color(0xFFD8A800),
      700: Color(0xFFB18A00),
      800: Color(0xFF896B00),
      900: Color(0xFF624D00),
    },
  );

  static const MaterialColor error = MaterialColor(
    0xFFE92215,
    <int, Color>{
      25: Color(0xFFFFF5F4),
      50: Color(0xFFFFFDCDA),
      100: Color(0xFFFFC5C1),
      200: Color(0xFFFFA19B),
      300: Color(0xFFFF7A72),
      400: Color(0xFFFF574D),
      500: Color(0xFFFF3838),
      600: Color(0xFFE92215),
      700: Color(0xFFD21A0E),
      800: Color(0xFFBE170C),
      900: Color(0xFFAB0A00),
    },
  );

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: primary,
    brightness: Brightness.light,
    scaffoldBackgroundColor: baseWhite,
    appBarTheme: const AppBarTheme(
      color: baseWhite,
      iconTheme: IconThemeData(color: baseBlack),
      titleTextStyle: TextStyle(
          color: baseBlack, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: baseBlack),
      bodyMedium: TextStyle(color: baseBlack),
    ),
    colorScheme: ColorScheme.light(
      primary: primary,
      secondary: primary[300]!,
      error: error,
      background: baseWhite,
      surface: gray[50]!,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: primary,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: baseBlack,
    appBarTheme: AppBarTheme(
      color: gray[900]!,
      iconTheme: const IconThemeData(color: baseWhite),
      titleTextStyle: const TextStyle(
          color: baseWhite, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: baseWhite),
      bodyMedium: TextStyle(color: baseWhite),
    ),
    colorScheme: ColorScheme.dark(
      primary: primary[300]!,
      secondary: primary[200]!,
      error: error[300]!,
      background: baseBlack,
      surface: gray[800]!,
    ),
  );
}
