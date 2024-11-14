import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/custom_utils.dart';
import '../../../../../../infrastructures/utils/date_and_time_utils.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../../../../shared/view/widgets/asset_icon.dart';
import '../../../../../shared/view/widgets/information_widget_with_icon.dart';
import '../../controller/management_event_details_controller.dart';

class ManagementEventInformation
    extends GetView<ManagementEventDetailsController> {
  const ManagementEventInformation({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Column(
        children: [
          _columnsAndDivider(),
          Utils.smallVerticalSpacer,
          _rateAverage(context),
          Utils.smallVerticalSpacer,
          _address(),
        ],
      );

  Widget _rateAverage(final BuildContext context) => Row(
        children: [
          _rateAverageIcon(),
          Utils.smallHorizontalSpacer,
          _rateAverageTitle(context),
          _rateValue(context)
        ],
      );

  Text _rateAverageTitle(final BuildContext context) => Text(
        'میانگین بازخورد:',
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
      );

  AssetIcon _rateAverageIcon() => const AssetIcon(
        path: 'lib/assets/menu_icons/event_survey.png',
        size: 18,
      );

  Expanded _rateValue(final BuildContext context) => Expanded(
        child: controller.eventDetails.averageOfRate != null
            ? _stars(context)
            : Text(
                'بدون بازخورد',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 11),
                textAlign: TextAlign.end,
                maxLines: 2,
              ),
      );

  Widget _stars(final BuildContext context) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: RatingBar.builder(
          ignoreGestures: true,
          initialRating: controller.eventDetails.averageOfRate!,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 20,
          unratedColor: CustomMilkyTheme.accentColor.withOpacity(0.4),
          itemBuilder: (final context, final index) => Icon(
            Icons.star_rate_rounded,
            color: CustomMilkyTheme.primaryColor,
          ),
          onRatingUpdate: (final value) {},
        ),
      );

  Widget _columnsAndDivider() => IntrinsicHeight(
        child: Row(
          children: [
            _rateAndClockAndDate(),
            Utils.tinyHorizontalSpacer,
            _divider(),
            Utils.tinyHorizontalSpacer,
            _spaceAndContactTypeAndStatus(),
          ],
        ),
      );

  Widget _address() => InformationWidgetWithIcon(
        label: 'آدرس:',
        value: controller.eventDetails.address,
        iconPath: 'lib/assets/menu_icons/address.png',
      );

  Widget _divider() => VerticalDivider(
        color: CustomMilkyTheme.primaryColor,
        width: 2,
      );

  Widget _rateAndClockAndDate() => Expanded(
        child: Column(
          children: [
            _minimumRate(),
            Utils.smallVerticalSpacer,
            _clock(),
            Utils.smallVerticalSpacer,
            _date(),
          ],
        ),
      );

  Widget _spaceAndContactTypeAndStatus() => Expanded(
        child: Column(
          children: [
            _remainingSpace(),
            Utils.smallVerticalSpacer,
            _contactType(),
            Utils.smallVerticalSpacer,
            _executeStatus(),
          ],
        ),
      );

  Widget _executeStatus() => InformationWidgetWithIcon(
        label: 'وضعیت اجرا',
        iconPath: 'lib/assets/menu_icons/event_status.png',
        value: controller.eventDetails.isExecuted ? 'اجرا شده' : 'در انتظار',
      );

  Widget _date() => InformationWidgetWithIcon(
        label: 'تاریخ برگزاری:',
        value: DateAndTimeUtils.standardDateRangeFormatter(
          controller.eventDetails.startDate,
          controller.eventDetails.endDate,
        ),
        iconPath: 'lib/assets/menu_icons/calendar.png',
      );

  Widget _contactType() => InformationWidgetWithIcon(
        label: 'مخاطب:',
        value: controller.eventDetails.contactType.name,
        iconPath: 'lib/assets/menu_icons/profile.png',
      );

  Widget _remainingSpace() => InformationWidgetWithIcon(
        label: 'ظرفیت باقی مانده:',
        value: CustomUtils.calculateEventFreeSpace(
          controller.eventDetails.maxCapacity,
          controller.eventDetails.filledCapacity,
        ),
        iconPath: 'lib/assets/menu_icons/available_capacity.png',
      );

  Widget _clock() => InformationWidgetWithIcon(
        label: 'ساعت:',
        value: DateAndTimeUtils.timeRangeFormatter(
          controller.eventDetails.startDate,
          controller.eventDetails.endDate,
        ),
        iconPath: 'lib/assets/menu_icons/clock.png',
      );

  Widget _minimumRate() => InformationWidgetWithIcon(
        label: 'امتیاز مورد نیاز:',
        value: controller.eventDetails.minimumRate.toString(),
        iconPath: 'lib/assets/menu_icons/rate.png',
      );
}
