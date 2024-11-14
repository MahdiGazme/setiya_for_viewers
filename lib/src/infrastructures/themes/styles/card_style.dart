import 'package:flutter/material.dart';
import '../custom_milky_theme.dart';

class MilkyCardStyle {
  MilkyCardStyle._();

  static CardTheme getStyle(final BuildContext context) => CardTheme(
        surfaceTintColor: CustomMilkyTheme.secondaryColor,
        elevation: 2.5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              CustomMilkyTheme.borderRadiusSemiRound,
            ),
          ),
        ),
      );
}
