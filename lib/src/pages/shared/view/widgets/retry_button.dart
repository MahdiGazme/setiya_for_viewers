import 'package:flutter/material.dart';

import '../../../../infrastructures/themes/custom_milky_theme.dart';

class RetryButton extends StatelessWidget {
  final void Function()? onTap;

  const RetryButton({this.onTap, final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body();

  Widget _body() => Center(
        child: ElevatedButton(
          onPressed: onTap,
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(CustomMilkyTheme.warningColor),
              minimumSize: MaterialStateProperty.all(
                const Size(105, 42),
              )),
          child: const Text('تلاش مجدد'),
        ),
      );
}
