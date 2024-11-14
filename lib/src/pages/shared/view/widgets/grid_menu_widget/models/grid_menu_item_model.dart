import 'package:flutter/material.dart';

class GridMenuItem {
  final void Function() onTap;
  final String? roleKey;
  final String title;
  final Widget child;

  GridMenuItem({
    required this.onTap,
    required this.title,
    required this.child,
    this.roleKey,
  });
}
