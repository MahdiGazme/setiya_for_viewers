import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../../infrastructures/utils/date_and_time_utils.dart';

class SetiaDateRangePicker extends StatelessWidget {
  final Widget? label;
  final Widget? pickerIcon;
  final JalaliRange? initialDataRange;
  final Jalali startDate;
  final Jalali endDate;
  final bool enabled;
  final String? Function(String? value)? validator;
  final AutovalidateMode? autoValidateMode;
  final void Function(JalaliRange dateRange) onDatePicked;
  final TextEditingController _controller = TextEditingController();

  SetiaDateRangePicker({
    required this.onDatePicked,
    required this.startDate,
    required this.endDate,
    this.initialDataRange,
    this.validator,
    this.autoValidateMode,
    this.enabled = true,
    this.label,
    this.pickerIcon,
    final Key? key,
  }) : super(key: key) {
    _controller.text =
        DateAndTimeUtils.dateWithMountNameRangeFormatter(initialDataRange);
  }

  @override
  Widget build(final BuildContext context) => TextFormField(
        controller: _controller,
        readOnly: true,
        enabled: enabled,
        validator: validator,
        autovalidateMode: autoValidateMode,
        onTap: () => _onTap(context),
        decoration: _decoration(context),
      );

  InputDecoration _decoration(final BuildContext context) => InputDecoration(
        label: label,
        suffixIcon: pickerIcon ??
            const Icon(
              Icons.date_range_rounded,
            ),
      );

  Future<void> _onTap(final BuildContext context) async {
    final pickedDate = await showPersianDateRangePicker(
      context: context,
      initialDateRange: initialDataRange,
      firstDate: startDate,
      lastDate: endDate,
    );
    if (pickedDate != null) {
      _controller.text =
          DateAndTimeUtils.dateWithMountNameRangeFormatter(pickedDate);
      onDatePicked.call(pickedDate);
    }
  }
}
