import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../../../../shared/view/widgets/date_picker/setia_date_time_picker.dart';
import '../../controllers/base_new_form_controller.dart';

class NewsFormExpireDate<T extends BaseNewsFormController> extends GetView<T> {
  const NewsFormExpireDate({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => DecoratedBox(
        decoration: _bodyDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Obx(
            () => Column(
              children: [
                _expireDateStatusField(),
                Utils.smallVerticalSpacer,
                _datePicker()
              ],
            ),
          ),
        ),
      );

  Widget _expireDateStatusField() => DecoratedBox(
        decoration: _radiosDecoration(),
        child: Padding(
          padding: Utils.tinyPadding,
          child: Row(
            children: [
              _expireDateStatusText(),
              _hasNotExpireDateRadio(),
              Utils.mediumHorizontalSpacer,
              _hasExpireDateRadio(),
            ],
          ),
        ),
      );

  Widget _datePicker() => Obx(
        () => SetiaDateTimePicker(
          initialDate: controller.expireDate.value,
          startDate: Jalali.now().addDays(1),
          endDate: Jalali.now().addYears(2),
          enabled: controller.hasExpireDate.value,
          validator: controller.expireDateValidator,
          label: const Text('انتخاب تاریخ'),
          onDatePicked: (final date) => controller.expireDate.value = date,
        ),
      );

  Widget _hasExpireDateRadio() => Row(
        children: [
          const Text('دارد'),
          Radio<bool>(
            value: true,
            groupValue: controller.hasExpireDate.value,
            onChanged: (final value) => controller.hasExpireDate.value = value!,
          ),
        ],
      );

  Widget _hasNotExpireDateRadio() => Row(
        children: [
          const Text('ندارد'),
          Radio<bool>(
            value: false,
            groupValue: controller.hasExpireDate.value,
            onChanged: (final value) => controller.hasExpireDate.value = value!,
          ),
        ],
      );

  Widget _expireDateStatusText() => const Expanded(
        child: Text('وضعیت تاریخ انقضا:'),
      );

  BoxDecoration _radiosDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
        color: CustomMilkyTheme.secondaryColor,
      );

  BoxDecoration _bodyDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
        color: CustomMilkyTheme.primaryColor.shade300,
      );
}
