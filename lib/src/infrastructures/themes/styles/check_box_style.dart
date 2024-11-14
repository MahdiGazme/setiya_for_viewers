import 'package:flutter/material.dart';
import '../custom_milky_theme.dart';

class MilkyCheckBoxStyle {
  MilkyCheckBoxStyle._();

  static CheckboxThemeData getStyle(final BuildContext context) =>
      CheckboxThemeData(
        checkColor: MaterialStateProperty.all(
          CustomMilkyTheme.secondaryColor,
        ),
        fillColor: MaterialStateProperty.all(
          CustomMilkyTheme.primaryColor,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
      );
}
