import 'package:flutter/material.dart';

class SetiaFAB extends StatelessWidget {
  final Widget child;
  final int duration;
  final double position;

  const SetiaFAB({
    required this.child,
    this.position = 0,
    this.duration = 180,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body();

  Widget _body() => Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: duration),
            left: position,
            bottom: 0,
            child: child,
          ),
        ],
      );
}
