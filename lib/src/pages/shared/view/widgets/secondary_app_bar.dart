import 'package:flutter/material.dart';

import '../../../../infrastructures/themes/custom_milky_theme.dart';
import 'logo.dart';

class SecondaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final Widget? title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Widget? leading;
  final PreferredSizeWidget? bottom;

  const SecondaryAppBar({
    this.title,
    this.actions,
    this.centerTitle = true,
    this.leading,
    this.preferredSize = const Size(0, 66.0),
    this.bottom,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Theme(
        data: Theme.of(context).copyWith(useMaterial3: false),
        child: AppBar(
          bottom: bottom,
          toolbarHeight: preferredSize.height,
          title: title,
          surfaceTintColor: CustomMilkyTheme.secondaryColor,
          leading: leading,
          centerTitle: centerTitle,
          actions: actions ??
              [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SetiaLogo(
                    color: CustomMilkyTheme.primaryLogoColor,
                  ),
                )
              ],
        ),
      );
}
