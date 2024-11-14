import 'package:flutter/material.dart';

import '../custom_milky_theme.dart';
import '../styles/app_bar_style.dart';
import '../styles/card_style.dart';
import '../styles/check_box_style.dart';
import '../styles/dialog_style.dart';
import '../styles/elevated_button_style.dart';
import '../styles/floating_action_button_style.dart';
import '../styles/outlined_button_style.dart';
import '../styles/radio_style.dart';
import '../styles/text_field_style.dart';

class MilkyThemeData {
  MilkyThemeData._();

  static ThemeData getTheme(final BuildContext context) => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          background: CustomMilkyTheme.backgroundColor,
          error: CustomMilkyTheme.dangerColor,
          primary: CustomMilkyTheme.primaryColor,
          secondary: CustomMilkyTheme.secondaryColor,
          surface: CustomMilkyTheme.secondaryColor,
          onSurface: CustomMilkyTheme.accentColor,
        ),
        disabledColor: CustomMilkyTheme.disabledColor,
        dialogTheme: MilkyDialogStyle.getStyle(context),
        scaffoldBackgroundColor: CustomMilkyTheme.backgroundColor,
        appBarTheme: AppBarStyle.getStyle(context),
        elevatedButtonTheme: MilkyElevatedButtonStyle.getStyle(context),
        textTheme: Theme.of(context).textTheme,
        inputDecorationTheme: MilkyTextFieldStyle.getStyle(context),
        checkboxTheme: MilkyCheckBoxStyle.getStyle(context),
        radioTheme: RadioStyle.getStyle(context),
        floatingActionButtonTheme: FloatingActionButtonStyle.getStyle(context),
        outlinedButtonTheme: MilkyOutlinedButtonStyle.getStyle(context),
        cardTheme: MilkyCardStyle.getStyle(context),
      );
}
