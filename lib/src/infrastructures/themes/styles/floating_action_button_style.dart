import 'package:flutter/material.dart';

import '../custom_milky_theme.dart';

class FloatingActionButtonStyle {
  FloatingActionButtonStyle._();

  static FloatingActionButtonThemeData getStyle(final BuildContext context) =>
      FloatingActionButtonThemeData(

        backgroundColor: CustomMilkyTheme.primaryColor.shade300,
        foregroundColor: CustomMilkyTheme.accentColor,
      );
}
