import 'package:flutter/material.dart';

import '../custom_milky_theme.dart';

class MilkyTextStyle {
  MilkyTextStyle._();

  static TextTheme getStyle(final BuildContext context) => TextTheme(
        titleLarge: TextStyle(
          color: CustomMilkyTheme.textColor,
          fontFamily: CustomMilkyTheme.fontFamilyPrimary,
        ),
        bodyLarge: TextStyle(
          color: CustomMilkyTheme.textColor,
          fontFamily: CustomMilkyTheme.fontFamilyPrimary,
        ),
        bodyMedium: TextStyle(
          color: CustomMilkyTheme.textColor,
          fontFamily: CustomMilkyTheme.fontFamilyPrimary,
        ),
        bodySmall: TextStyle(
          color: CustomMilkyTheme.textColor,
          fontFamily: CustomMilkyTheme.fontFamilyPrimary,
        ),
        headlineSmall: TextStyle(
          color: CustomMilkyTheme.textColor,
          fontFamily: CustomMilkyTheme.fontFamilyPrimary,
        ),
        headlineMedium: TextStyle(
          color: CustomMilkyTheme.textColor,
          fontFamily: CustomMilkyTheme.fontFamilyPrimary,
        ),
        headlineLarge: TextStyle(
          color: CustomMilkyTheme.textColor,
          fontFamily: CustomMilkyTheme.fontFamilyPrimary,
        ),
        displaySmall: TextStyle(
          color: CustomMilkyTheme.textColor,
          fontFamily: CustomMilkyTheme.fontFamilyPrimary,
        ),
        displayMedium: TextStyle(
          color: CustomMilkyTheme.textColor,
          fontFamily: CustomMilkyTheme.fontFamilyPrimary,
        ),
        displayLarge: TextStyle(
          color: CustomMilkyTheme.textColor,
          fontFamily: CustomMilkyTheme.fontFamilyPrimary,
        ),
        labelMedium: TextStyle(
          color: CustomMilkyTheme.textColor,
          fontFamily: CustomMilkyTheme.fontFamilyPrimary,
        ),
        labelLarge: TextStyle(
          color: CustomMilkyTheme.textColor,
          fontFamily: CustomMilkyTheme.fontFamilyPrimary,
        ),
        titleMedium: TextStyle(
          color: CustomMilkyTheme.textColor,
          fontFamily: CustomMilkyTheme.fontFamilyPrimary,
        ),
        titleSmall: TextStyle(
          color: CustomMilkyTheme.textColor,
          fontFamily: CustomMilkyTheme.fontFamilyPrimary,
        ),
        labelSmall: TextStyle(
          color: CustomMilkyTheme.textColor,
          fontFamily: CustomMilkyTheme.fontFamilyPrimary,
        ),
      );
}
