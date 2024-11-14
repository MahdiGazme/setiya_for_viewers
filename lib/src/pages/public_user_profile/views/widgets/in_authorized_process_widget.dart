import 'package:flutter/material.dart';

import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/utils.dart';

class InAuthorizeProcessWidget extends StatelessWidget {
  const InAuthorizeProcessWidget({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Card(
        child: Padding(
          padding: Utils.smallPadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoIcon(),
              Utils.smallHorizontalSpacer,
              _hint(context)
            ],
          ),
        ),
      );

  Widget _hint(final BuildContext context) => Expanded(
    child: Text(
          'کاربر گرامی وضعیت احراز هویت شما در دست بررسی است',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: CustomMilkyTheme.warningColor,
              ),
        ),
  );

  Widget _infoIcon() => Icon(
        Icons.info_outline_rounded,
        color: CustomMilkyTheme.infoColor,
      );
}
