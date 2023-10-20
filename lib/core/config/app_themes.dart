import 'package:flutter/material.dart';
import 'package:translator_app/core/constant/styles.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0XFFEBEDEF),
      onPrimary: Color(0XFF161719),
      background: Color(0XFF161719),
      onBackground: Color(0XFFEBEDEF),
      secondary: Color(0xFFEE533F),
      onSecondary: Color(0XFFEBEDEF),
      surface: Color(0XFF242527),
      onSurface: Color(0XFFA3A4A6),
      surfaceVariant: Color(0XFF131416),
      outline: Color(0XFF434446),
      error: Colors.red,
      onError: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: borderRadiusDefault),
        padding: const EdgeInsets.all(paddingDefault),
      ),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0XFF000000),
      onPrimary: Color(0XFFEBEDEF),
      background: Color(0XFFEBEDEF),
      onBackground: Color(0XFF000000),
      secondary: Color(0xFFEE533F),
      onSecondary: Color(0XFFEBEDEF),
      surface: Color(0XFFCACACA),
      onSurface: Color(0XFF000000),
      surfaceVariant: Color(0XFFFFFFFF),
      outline: Color(0XFF949494),
      error: Colors.red,
      onError: Colors.white,
    ),
  );
}
