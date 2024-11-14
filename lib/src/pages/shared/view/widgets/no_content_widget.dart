import 'package:flutter/material.dart';

import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/utils.dart';
import 'logo.dart';

class NoContentWidget extends StatelessWidget {
  final String message;
  final double size;

  const NoContentWidget({
    required this.message,
    this.size = 300,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _logo(),
            Utils.largeVerticalSpacer,
            _infoText(context),
          ],
        ),
      );

  Widget _logo() => SetiaLogo(
        color: CustomMilkyTheme.accentColor.withOpacity(0.2),
        size: size,
      );

  Widget _infoText(final BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: CustomMilkyTheme.accentColor,
          ),
          Utils.smallHorizontalSpacer,
          Expanded(
            flex: 10,
            child: Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: CustomMilkyTheme.infoColor),
            ),
          ),
        ],
      );
}
