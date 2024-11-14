import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../infrastructures/utils/custom_utils.dart';
import '../../../../../infrastructures/utils/date_and_time_utils.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/view/widgets/information_widget_with_icon.dart';
import '../../controller/children_event_history_details_controller.dart';

class ChildrenEventHistoryDetailsInformation
    extends GetView<ChildrenEventHistoryDetailsController> {
  const ChildrenEventHistoryDetailsInformation({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Column(
        children: [
          _columnsAndDivider(),
          Utils.smallVerticalSpacer,
          _address(),
        ],
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
        label: 'وضعیت شرکت',
        iconPath: 'lib/assets/menu_icons/event_status.png',
        value: controller.eventDetails.executionStatus.name,
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
