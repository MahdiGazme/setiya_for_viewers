import 'package:flutter/material.dart';

class PageLoadingIndicator extends StatelessWidget {
  final double? size;
  final Color? color;

  const PageLoadingIndicator({
    this.size,
    this.color,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body();

  Widget _body() => Center(
        child: SizedBox(
          height: size,
          width: size,
          child: CircularProgressIndicator(
            color: color,
          ),
        ),
      );
}
