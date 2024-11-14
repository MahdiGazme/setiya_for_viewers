import 'package:flutter/material.dart';

class EventImageHoleClip extends CustomClipper<Path> {
  final double space;

  EventImageHoleClip({required this.space});

  @override
  Path getClip(final Size size) {
    final path = Path();
    final halfSpace = space / 2;
    final spaceWithPadding = space + space / 100 * 20;

    path.moveTo(
      0,
      spaceWithPadding + 25,
    );
    path.quadraticBezierTo(
      5,
      spaceWithPadding,
      25,
      spaceWithPadding,
    );
    path.lineTo(halfSpace, spaceWithPadding);
    path.quadraticBezierTo(
      spaceWithPadding,
      spaceWithPadding,
      spaceWithPadding,
      halfSpace,
    );
    path.lineTo(spaceWithPadding, 25);
    path.quadraticBezierTo(
      spaceWithPadding,
      5,
      spaceWithPadding + 25,
      0,
    );

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant final CustomClipper<Path> oldClipper) => true;
}
