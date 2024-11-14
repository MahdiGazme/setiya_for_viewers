import 'package:flutter/material.dart';

import '../custom_milky_theme.dart';

class RadioStyle {
  RadioStyle._();

  static RadioThemeData getStyle(final BuildContext context) =>
       RadioThemeData(
        fillColor: MaterialStatePropertyAll(CustomMilkyTheme.primaryColor),
      );
}
