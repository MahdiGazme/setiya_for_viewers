import 'package:flutter/material.dart';

import '../custom_milky_theme.dart';

class MilkyElevatedButtonStyle {
  MilkyElevatedButtonStyle._();

  static ElevatedButtonThemeData getStyle(final BuildContext context) =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
          maximumSize: MaterialStateProperty.all(
            const Size(200, 100),
          ),
          minimumSize: MaterialStateProperty.all(
            const Size(70, 42),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(CustomMilkyTheme.borderRadiusSemiRound),
              ),
            ),
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            CustomMilkyTheme.liteTextColor,
          ),
          backgroundColor: MaterialStateProperty.all(
            CustomMilkyTheme.primaryColor,
          ),
          enableFeedback: true,
          overlayColor: MaterialStateProperty.all<Color>(
            CustomMilkyTheme.liteTextColor.withOpacity(0.1),
          ),
        ),
      );
}
