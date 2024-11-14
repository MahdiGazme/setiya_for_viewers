import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../../../../shared/view/widgets/date_picker/setia_date_range_picker.dart';
import '../../../../../shared/view/widgets/date_picker/setia_time_picker.dart';
import '../../../../../shared/view/widgets/required_text_field_label.dart';
import '../../controllers/base_event_controller.dart';

class EventFormDateAndTime<T extends BaseEventController> extends GetView<T> {
  const EventFormDateAndTime({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => DecoratedBox(
        decoration: _containersDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(context),
              Utils.smallVerticalSpacer,
              _date(),
              Utils.smallVerticalSpacer,
              _startTime(),
              Utils.smallVerticalSpacer,
              _endTime(),
            ],
          ),
        ),
      );

  Widget _endTime() => SetiaTimePicker(
        onDatePicked: (final time) => controller.endTime = time,
        pickerIcon: const Icon(
          Icons.access_time_rounded,
        ),
        label: const Text('ساعت پایان'),
        initialTime: controller.endTime,
        validator: (final value) => controller.startAndEndTimeValidator(),
      );

  Widget _startTime() => SetiaTimePicker(
        onDatePicked: (final time) => controller.startTime = time,
        pickerIcon: const Icon(
          Icons.access_time_rounded,
        ),
        label: const Text('ساعت شروع'),
        initialTime: controller.startTime,
        validator: (final value) => controller.startAndEndTimeValidator(),
      );

  Widget _date() => SetiaDateRangePicker(
        startDate: Jalali.now(),
        endDate: Jalali.now().addMonths(6),
        onDatePicked: (final dateRange) =>
            controller.dateRange.value = dateRange,
        validator: (final value) => Utils.regularValidator(value!),
        label: const RequiredTextFieldLabel(
          label: 'محدوده زمانی',
        ),
        initialDataRange: controller.dateRange.value,
        pickerIcon: const Icon(
          Icons.date_range_rounded,
        ),
      );

  Widget _title(final BuildContext context) => Text(
        'تاریخ و ساعت:',
        style: Theme.of(context).textTheme.bodyLarge,
      );

  BoxDecoration _containersDecoration() => BoxDecoration(
        color: CustomMilkyTheme.primaryColor.shade300,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );
}
