import 'package:flutter/material.dart';

class CustomColors {
  static const dividerLine = Color(0xffFFE4E8); // pastel pink
  static const cardColor = Color(0xffFFF0F5); // very light pink
  static const primaryTextColor =
      Color(0xff4A4A4A); // slightly darker for contrast
  static const secondaryTextColor =
      Color(0xff7B7B7B); // for less important text
  static const firstGradientColor = Color(0xffFFB6C1); // pastel pink
  static const secondGradientColor = Color(0xffFFC0CB); // pastel pink
  static const accentColor = Color(0xffB2EBF2); // pastel blue for highlights
  static const highlightColor = Color(0xffF8BBD0); // pastel pink highlight
  static const cardShadow = BoxShadow(
    color: Color(0x1A000000), // subtle shadow
    blurRadius: 12,
    offset: Offset(0, 4),
  );
  static const cardRadius = 20.0;
}

class CustomDarkColors {
  static const dividerLine = Color(0xff2C2C34);
  static const cardColor = Color(0xff3A3A44);
  static const primaryTextColor = Color(0xffE0E0E0);
  static const secondaryTextColor = Color(0xffB0B0B0);
  static const firstGradientColor = Color(0xffFF69B4);
  static const secondGradientColor = Color(0xffFF1493);
  static const accentColor = Color(0xff80DEEA);
  static const highlightColor = Color(0xffF06292);
  static const cardShadow = BoxShadow(
    color: Color(0x33000000),
    blurRadius: 12,
    offset: Offset(0, 4),
  );
  static const cardRadius = 20.0;
}
