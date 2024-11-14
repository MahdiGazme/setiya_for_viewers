import 'package:flutter/material.dart';

class AssetIcon extends StatelessWidget {
  final String path;
  final double? size;

  const AssetIcon({
    required this.path,
    this.size ,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Image.asset(
        path,
        fit: BoxFit.cover,
        package: 'setia_module',
        height: size,
        width: size,
      );
}
