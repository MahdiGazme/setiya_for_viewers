import 'package:flutter/material.dart';

import '../custom_milky_theme.dart';

class MilkyDialogStyle {
  MilkyDialogStyle._();

  static DialogTheme getStyle(final BuildContext context) => DialogTheme(
        backgroundColor: CustomMilkyTheme.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            CustomMilkyTheme.borderRadiusSemiRound,
          ),
        ),
      );
}
