import 'package:flutter/material.dart';

class CustomMilkyTheme {
  static MaterialColor get primaryColor => _lightPrimaryColor();

  static MaterialColor _lightPrimaryColor() => const MaterialColor(0xffff4e81, {
        50: Color(0xfffdf4f6),
        100: Color(0xffffedf2),
        200: Color(0xffffdce6),
        300: Color(0xffffcad9),
        400: Color(0xffffb8cd),
        500: Color(0xffffa7c0),
        600: Color(0xffff95b3),
        700: Color(0xffff83a7),
        800: Color(0xffff719a),
        900: Color(0xffff608e),
      });

  static Color get liteTextColor => const Color(0xFFFFFFFF);

  static Color get textColor => const Color(0xFF14166E);

  static Color get secondaryColor => const Color(0xFFFFFFFF);

  static Color get accentColor => const Color(0xFF191C80);

  static Color get infoColor => const Color(0xFF5A5C98);

  static Color get successColor => const Color(0xFF51D904);

  static Color get warningColor => const Color(0xffffbb0f);

  static Color get dangerColor => const Color(0xffff4040);

  static Color get selectedColor => Colors.pinkAccent;

  static Color get primaryLogoColor => secondaryColor;

  static Color get disabledColor => const Color(0xFF81839B);

  static Color get backgroundColor => const Color(0xffF4F6F6);

  static const String fontFamilyPrimary = 'IRANSans';
  static const String fontFamilySecondary = 'IRANSans';
  static const double borderRadiusRectangle = 2.0;
  static const double borderRadiusCircular = 100;
  static const double borderRadiusRound = 35.0;
  static const double borderRadiusSemiRound = 11.0;
}
