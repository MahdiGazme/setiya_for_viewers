import 'package:flutter/material.dart';

import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/utils.dart';

class SetiyaElevatedButton extends StatelessWidget {
  final bool showLoading;
  final VoidCallback onPressed;
  final ButtonStyle? style;
  final Widget child;

  const SetiyaElevatedButton({
    required this.onPressed,
    required this.child,
    this.style,
    this.showLoading = false,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => ElevatedButton(
        onPressed: showLoading ? null : onPressed,
        style: style,
        child: childWithLoading(),
      );

  Widget childWithLoading() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          if (showLoading)
            Padding(
              padding: Utils.tinyPadding,
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: CustomMilkyTheme.secondaryColor,
                ),
              ),
            ),
        ],
      );
}
