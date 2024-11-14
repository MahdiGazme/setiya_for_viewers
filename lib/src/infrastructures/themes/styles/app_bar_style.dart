import 'package:flutter/material.dart';
import '../custom_milky_theme.dart';

class AppBarStyle {
  AppBarStyle._();

  static AppBarTheme getStyle(final BuildContext context) => AppBarTheme(

        backgroundColor: CustomMilkyTheme.primaryColor,
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          color: CustomMilkyTheme.secondaryColor,
        ),
        actionsIconTheme: IconThemeData(
          color: CustomMilkyTheme.secondaryColor,
        ),
        titleTextStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: CustomMilkyTheme.liteTextColor),
        foregroundColor: CustomMilkyTheme.liteTextColor,
      );
}
