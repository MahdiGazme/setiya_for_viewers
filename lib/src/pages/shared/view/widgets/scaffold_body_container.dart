import 'package:flutter/material.dart';

import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/utils.dart';

class ScaffoldBodyContainer extends StatelessWidget {
  final Widget? child;

  const ScaffoldBodyContainer({
    this.child,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Container(
        decoration: BoxDecoration(
          color: CustomMilkyTheme.backgroundColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(CustomMilkyTheme.borderRadiusRound),
            topLeft: Radius.circular(CustomMilkyTheme.borderRadiusRound),
          ),
        ),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 15, horizontal: Utils.tinySpace),
            child: child,
          ),
        ),
      );
}
