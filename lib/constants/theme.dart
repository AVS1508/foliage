// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:foliage/constants/colors.dart';

class GlobalTheme {
  static var lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'SourceSansPro',
    scaffoldBackgroundColor: CustomColors.offWhite,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      background: CustomColors.offWhite,
      onBackground: CustomColors.charadeBlack,
      error: CustomColors.errorRed,
      onError: CustomColors.trueWhite,
      primary: CustomColors.foliageGreen,
      onPrimary: CustomColors.trueWhite,
      secondary: CustomColors.materialBlue,
      onSecondary: CustomColors.trueWhite,
      surface: CustomColors.cadetGrey,
      onSurface: CustomColors.trueWhite,
    ),
  );
  static var darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'SourceSansPro',
    scaffoldBackgroundColor: CustomColors.charadeBlack,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      background: CustomColors.charadeBlack,
      onBackground: CustomColors.offWhite,
      error: CustomColors.errorRed,
      onError: CustomColors.trueWhite,
      primary: CustomColors.foliageGreen,
      onPrimary: CustomColors.trueWhite,
      secondary: CustomColors.materialBlue,
      onSecondary: CustomColors.trueWhite,
      surface: CustomColors.cadetGrey,
      onSurface: CustomColors.trueWhite,
    ),
  );
}
