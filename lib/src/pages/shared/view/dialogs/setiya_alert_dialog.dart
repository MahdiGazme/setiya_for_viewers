import 'dart:math' as math;

import 'package:flutter/material.dart';


class SetiyaAlertDialog extends StatelessWidget {
  final Widget? icon;
  final Widget? title;
  final Widget? content;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? surfaceTintColor;
  final List<Widget>? actions;
  final TextStyle? titleTextStyle;

  const SetiyaAlertDialog({
    final Key? key,
    this.icon,
    this.title,
    this.content,
    this.iconColor,
    this.backgroundColor,
    this.surfaceTintColor,
    this.actions,
    this.titleTextStyle,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => AlertDialog(
        icon: icon,
        iconColor: iconColor,
        backgroundColor: backgroundColor,
        surfaceTintColor: surfaceTintColor,
        title: title,
        titleTextStyle: titleTextStyle != null
            ? titleTextStyle!
            : Theme.of(context).textTheme.titleMedium,
        actions: actions,
        content: content != null
            ? SizedBox(
                width: math.min(MediaQuery.of(context).size.width, 600) - 110,
                child: content,
              )
            : null,
      );
}
