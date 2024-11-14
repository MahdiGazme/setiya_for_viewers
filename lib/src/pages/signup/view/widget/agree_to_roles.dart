import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../infrastructures/utils/utils.dart';

class AgreeToRoles extends StatelessWidget {
  final bool isAgreed;
  final void Function() onRulesTap;
  final void Function(
    bool value,
  ) onChanged;

  const AgreeToRoles({
    required this.onRulesTap,
    required this.onChanged,
    required this.isAgreed,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Row(
        children: [
          Checkbox(
            value: isAgreed,
            onChanged: (final value) => onChanged.call(value!),
          ),
          Utils.smallHorizontalSpacer,
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'با ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextSpan(
                  text: 'شرایط و قوانین ',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.blue,
                      ),
                  recognizer: TapGestureRecognizer()..onTap = onRulesTap,
                ),
                TextSpan(
                  text: 'استفاده از این نرم افزار موافقم',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ]),
            ),
          )
        ],
      );
}
