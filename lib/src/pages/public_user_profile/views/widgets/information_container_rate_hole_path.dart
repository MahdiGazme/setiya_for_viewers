import 'package:flutter/material.dart';

class InformationContainerRateHolePath extends CustomClipper<Path> {
  final double space;

  InformationContainerRateHolePath({required this.space});

  @override
  Path getClip(final Size size) {
    final path = Path();
    final halfWidth = size.width / 2;
    final halfSpace = space / 2;
    final curve = space / (space /2);
    final height = halfSpace ;
    path.lineTo(halfWidth - halfSpace, 0);
    path.cubicTo(halfWidth - halfSpace, 0, halfWidth - halfSpace + curve,
        height, halfWidth, height);

    path.cubicTo(halfWidth, height, halfWidth + halfSpace - curve, height,
        halfWidth + halfSpace, 0);

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant final CustomClipper<Path> oldClipper) => true;
}