import 'package:flutter/material.dart';

import '../../../../infrastructures/themes/custom_milky_theme.dart';
import 'logo.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const PrimaryAppBar({
    this.preferredSize = const Size(0, 85.0),
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => AppBar(
        toolbarHeight: preferredSize.height,
        actions: [
          _logo(),
        ],
      );

  Widget _logo() => Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SetiaLogo(
                color: CustomMilkyTheme.primaryLogoColor,
              ),
            ),
          ],
        ),
      );
}
