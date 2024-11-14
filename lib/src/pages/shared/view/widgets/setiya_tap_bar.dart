import 'package:flutter/material.dart';

import '../../../../infrastructures/themes/custom_milky_theme.dart';

class SetiyaTabBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final bool isScrollable;

  final List<Tab> tabs;
  final void Function(int index) onTap;

  const SetiyaTabBar({
    required this.tabs,
    required this.onTap,
    this.isScrollable = false,
    this.preferredSize = const Size(0, 66.0),
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => TabBar(
        tabs: tabs,
        labelStyle: Theme.of(context).textTheme.bodySmall,
        indicatorColor: CustomMilkyTheme.secondaryColor,
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: isScrollable,
        onTap: onTap,
        splashBorderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusCircular,
        ),
      );
}
