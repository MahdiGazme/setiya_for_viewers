import 'package:flutter/material.dart';

import '../custom_milky_theme.dart';

class MilkyOutlinedButtonStyle {
  MilkyOutlinedButtonStyle._();

  static OutlinedButtonThemeData getStyle(final BuildContext context) =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: CustomMilkyTheme.primaryColor,
          maximumSize: const Size(200, 100),
          minimumSize: const Size(70, 42),
          side: BorderSide(
            width: 1.5,
            color: CustomMilkyTheme.primaryColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          enableFeedback: true,
        ),
      );
}
