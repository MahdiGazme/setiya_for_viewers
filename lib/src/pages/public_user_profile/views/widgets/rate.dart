import 'package:flutter/material.dart';

import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/view/widgets/rate_icon.dart';

class MemberRateWidget extends StatelessWidget {
  final String rate;

  const MemberRateWidget({
    required this.rate,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Container(
        height: 125,
        width: 125,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(
            width: 7,
            color: CustomMilkyTheme.primaryColor,
          ),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Padding(
            padding: Utils.tinyPadding,
            child: Column(
              children: [
                const RateIcon(),
                Utils.tinyVerticalSpacer,
                _rateText(context),
                Utils.tinyVerticalSpacer,
                _hint(context)
              ],
            ),
          ),
        ),
      );

  Text _hint(final BuildContext context) => Text(
        'برای پیشرفت در امتیاز\n در برنامه های ستیا\n شرکت کنید',
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: CustomMilkyTheme.infoColor, fontSize: 8),
      );

  RichText _rateText(final BuildContext context) => RichText(
        text: TextSpan(
          children: [
            TextSpan(text: rate, style: Theme.of(context).textTheme.bodyLarge),
            TextSpan(
                text: ' امتیاز',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: CustomMilkyTheme.accentColor.withOpacity(0.8))),
          ],
        ),
      );
}
