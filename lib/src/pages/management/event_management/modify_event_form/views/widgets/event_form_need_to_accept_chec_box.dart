import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../controllers/base_event_controller.dart';

class EventFormNeedToAcceptCheckBox<T extends BaseEventController>
    extends GetView<T> {
  const EventFormNeedToAcceptCheckBox({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => DecoratedBox(
        decoration: _containersDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            children: [
              _hint(context),
              Utils.smallVerticalSpacer,
              _checkBoxField(),
            ],
          ),
        ),
      );

  Widget _checkBoxField() => DecoratedBox(
        decoration: _checkBoxFieldDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Row(
            children: [
              _checkBoxFieldDescription(),
              _checkBoxLabel(),
              _checkBox(),
            ],
          ),
        ),
      );

  Widget _checkBoxLabel() => const Text('نیاز به تایید');

  Widget _checkBox() => Obx(
        () => Checkbox(
          value: controller.needAcceptMember.value,
          onChanged: (final value) => controller.needAcceptMember.value =
              !controller.needAcceptMember.value,
        ),
      );

  Widget _checkBoxFieldDescription() => const Expanded(
        child: Text(
          'وضعیت تایید ثبت نام:',
        ),
      );

  BoxDecoration _checkBoxFieldDecoration() => BoxDecoration(
        color: CustomMilkyTheme.backgroundColor,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );

  Widget _hint(final BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: CustomMilkyTheme.infoColor,
          ),
          Utils.smallHorizontalSpacer,
          _hintText(context),
        ],
      );

  Widget _hintText(final BuildContext context) => Expanded(
        child: Text(
          'در صورت فعال کردن '
          'گزینه "نیاز به تایید مدیر" همه'
          ' درخواست های شرکت در رویداد باید'
          ' توسط مدیر یا معاونت روابط عمومی'
          ' تایید شود',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: CustomMilkyTheme.infoColor,
              ),
        ),
      );

  BoxDecoration _containersDecoration() => BoxDecoration(
        color: CustomMilkyTheme.primaryColor.shade300,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );
}
