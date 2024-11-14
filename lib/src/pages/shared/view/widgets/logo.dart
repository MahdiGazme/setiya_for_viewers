import 'package:flutter/material.dart';

class SetiaLogo extends StatelessWidget {
  final Color? color;
  final double? size;

  const SetiaLogo({this.color, this.size, final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Image.asset(
        'lib/assets/images/logo_secondary.png',
        package: 'setia_module',
        color: color,
        fit: BoxFit.cover,
        height: size != null ? (size! / 100 * 80) : null,
        width: size,
      );
}
