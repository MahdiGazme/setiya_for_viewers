import 'package:flutter/material.dart';

import '../../../../infrastructures/utils/utils.dart';
import 'asset_icon.dart';

class RateIcon extends StatelessWidget {
  final double size;

  const RateIcon({
    this.size = 23,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size/2),
        ),
        child: Padding(
          padding: Utils.tinyPadding,
          child: AssetIcon(
            path: 'lib/assets/menu_icons/rate.png',
            size: size,
          ),
        ),
      );
}
