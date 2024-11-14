import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../../infrastructures/utils/date_and_time_utils.dart';

class SetiaDateTimePicker extends StatelessWidget {
  final Widget? label;
  final Widget? pickerIcon;
  final Jalali? initialDate;
  final Jalali startDate;
  final Jalali endDate;
  final bool enabled;
  final String? Function(String? value)? validator;
  final AutovalidateMode? autoValidateMode;
  final void Function(Jalali date) onDatePicked;
  final TextEditingController _controller = TextEditingController();

  SetiaDateTimePicker({
    required this.startDate,
    required this.endDate,
    required this.onDatePicked,
    this.validator,
    this.autoValidateMode,
    this.initialDate,
    this.enabled = true,
    this.label,
    this.pickerIcon,
    final Key? key,
  }) : super(key: key) {
    _controller.text = DateAndTimeUtils.dateWithMountNameFormatter(initialDate);
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
    final pickedDate = await showPersianDatePicker(
      context: context,
      initialDate: initialDate ?? startDate,
      firstDate: startDate,
      lastDate: endDate,
    );
    if (pickedDate != null) {
      _controller.text =
          DateAndTimeUtils.dateWithMountNameFormatter(pickedDate);
      onDatePicked.call(pickedDate);
    }
  }
}
