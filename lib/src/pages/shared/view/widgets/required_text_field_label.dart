import 'package:flutter/material.dart';

import '../../../../infrastructures/themes/custom_milky_theme.dart';

class RequiredTextFieldLabel extends StatelessWidget {
  final String label;

  const RequiredTextFieldLabel({
    required this.label,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => RichText(
        text: TextSpan(
          text: label,
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: ' *',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: CustomMilkyTheme.dangerColor,
                  ),
            )
          ],
        ),
      );
}
