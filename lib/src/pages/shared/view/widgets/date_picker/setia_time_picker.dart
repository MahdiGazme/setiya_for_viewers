import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../../infrastructures/utils/date_and_time_utils.dart';

class SetiaTimePicker extends StatelessWidget {
  final Widget? label;
  final Widget? pickerIcon;
  final TimeOfDay? initialTime;
  final bool enabled;
  final String? Function(String? value)? validator;
  final AutovalidateMode? autoValidateMode;
  final void Function(TimeOfDay time) onDatePicked;
  final TextEditingController _controller = TextEditingController();

  SetiaTimePicker({
    required this.onDatePicked,
    this.initialTime,
    this.validator,
    this.autoValidateMode,
    this.enabled = true,
    this.label,
    this.pickerIcon,
    final Key? key,
  }) : super(key: key) {
    _controller.text = DateAndTimeUtils.timeFormatter(initialTime);
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
    final pickedTime = await showPersianTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      _controller.text = DateAndTimeUtils.timeFormatter(pickedTime);
      onDatePicked.call(pickedTime);
    }
  }
}
