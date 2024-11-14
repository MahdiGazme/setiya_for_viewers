import 'package:flutter/material.dart';

import '../../../../infrastructures/utils/utils.dart';
import 'asset_icon.dart';

class InformationWidgetWithIcon extends StatelessWidget {
  final String label;
  final String? value;
  final String iconPath;
  final CrossAxisAlignment crossAxisAlignment;

  const InformationWidgetWithIcon({
    required this.label,
    required this.iconPath,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.value,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => Row(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          _icon(),
          Utils.smallHorizontalSpacer,
          _label(context),
          _value(context)
        ],
      );

  Widget _value(final BuildContext context) => Expanded(
        child: Text(
          value ?? 'ثبت نشده',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 11),
          textAlign: TextAlign.end,
          maxLines: 2,
        ),
      );

  Widget _label(final BuildContext context) => Text(
        label,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(fontWeight: FontWeight.w500, fontSize: 11),
      );

  Widget _icon() => AssetIcon(
        path: iconPath,
        size: 18,
      );
}
