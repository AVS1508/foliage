import 'package:flutter/material.dart';

class GlobalTheme {
  static var lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'SourceSansPro',
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      background: Colors.white,
      onBackground: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      primary: Colors.green,
      onPrimary: Colors.white,
      secondary: Colors.blueAccent,
      onSecondary: Colors.white,
      surface: Colors.blueGrey,
      onSurface: Colors.white,
    ),
  );
  static var darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'SourceSansPro',
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      background: Colors.black,
      onBackground: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      primary: Colors.green,
      onPrimary: Colors.white,
      secondary: Colors.blueAccent,
      onSecondary: Colors.white,
      surface: Colors.blueGrey,
      onSurface: Colors.white,
    ),
  );
}
