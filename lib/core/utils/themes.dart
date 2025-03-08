import 'package:flutter/material.dart';

import 'custom_colors.dart';

class Themes {
  static ThemeData lightmode = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: CustomColors.firstGradientColor,
    cardColor: CustomColors.cardColor,
    dividerColor: CustomColors.dividerLine,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: CustomColors.primaryTextColor),
      bodyMedium: TextStyle(color: CustomColors.primaryTextColor),
      titleLarge: TextStyle(color: CustomColors.primaryTextColor),
      titleMedium: TextStyle(color: CustomColors.primaryTextColor),
      titleSmall: TextStyle(color: CustomColors.primaryTextColor),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: CustomColors.primaryTextColor),
    ),
    colorScheme: ColorScheme.light(
      primary: CustomColors.firstGradientColor,
      secondary: CustomColors.secondGradientColor,
      surface: CustomColors.cardColor,
      onSurface: CustomColors.primaryTextColor,
    ),
  );

  static ThemeData darkmode = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF1A1A1A),
    primaryColor: CustomDarkColors.firstGradientColor,
    cardColor: CustomDarkColors.cardColor,
    dividerColor: CustomDarkColors.dividerLine,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: CustomDarkColors.primaryTextColor),
      bodyMedium: TextStyle(color: CustomDarkColors.primaryTextColor),
      titleLarge: TextStyle(color: CustomDarkColors.primaryTextColor),
      titleMedium: TextStyle(color: CustomDarkColors.primaryTextColor),
      titleSmall: TextStyle(color: CustomDarkColors.primaryTextColor),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: CustomDarkColors.primaryTextColor),
    ),
    colorScheme: ColorScheme.dark(
      primary: CustomDarkColors.firstGradientColor,
      secondary: CustomDarkColors.secondGradientColor,
      surface: CustomDarkColors.cardColor,
      onSurface: CustomDarkColors.primaryTextColor,
    ),
  );
}
