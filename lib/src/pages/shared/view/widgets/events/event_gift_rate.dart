import 'package:flutter/material.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../rate_icon.dart';

class EventGiftRate extends StatelessWidget {
  final int giftRate;

  const EventGiftRate({
    required this.giftRate,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Container(
        height: 80,
        width: 80,
        decoration: _decoration(),
        padding: Utils.smallPadding,
        child: _content(context),
      );

  BoxDecoration _decoration() => BoxDecoration(
        color: Colors.grey.shade300,
        shape: BoxShape.circle,
      );

  Widget _content(final BuildContext context) => Column(
        children: [
          _icon(),
          Utils.tinyVerticalSpacer,
          _text(context),
        ],
      );

  Widget _icon() => const RateIcon(
        size: 15,
      );

  Widget _text(final BuildContext context) => Expanded(
        child: RichText(
          maxLines: 2,
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
              text: '$giftRate ',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextSpan(
              text: 'امتیاز',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ]),
        ),
      );
}
