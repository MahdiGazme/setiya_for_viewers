import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../custom_milky_theme.dart';

class MilkyTextFieldStyle {
  MilkyTextFieldStyle._();

  static InputDecorationTheme getStyle(final BuildContext context) =>
      InputDecorationTheme(
        fillColor: CustomMilkyTheme.backgroundColor,
        filled: true,
        contentPadding: Utils.smallPadding,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            width: 2,
            color: CustomMilkyTheme.accentColor.withOpacity(0.8),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            width: 2.5,
            color: CustomMilkyTheme.dangerColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            width: 2.5,
            color: CustomMilkyTheme.accentColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            width: 1.5,
            color: CustomMilkyTheme.disabledColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            width: 2.5,
            color: CustomMilkyTheme.accentColor.withOpacity(0.4),
          ),
        ),
        alignLabelWithHint: true,
        counterStyle: Theme.of(context).textTheme.bodySmall,
        errorStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: CustomMilkyTheme.dangerColor),
        errorMaxLines: 1,
        labelStyle: Theme.of(context).textTheme.bodyMedium,
      );
}
