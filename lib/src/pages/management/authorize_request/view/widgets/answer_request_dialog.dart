import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/view/widgets/setiya_elevated_button.dart';
import '../../controller/authorize_request_controller.dart';

class AnswerDialogRequest extends GetView<AuthorizeRequestController> {
  const AnswerDialogRequest({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => AlertDialog(
        title: Text(
          LocaleKeys
              .setia_module_pages_management_authorize_request_request_response_dialog_title
              .tr,
        ),
        icon: const Icon(Icons.warning_amber_rounded),
        iconColor: CustomMilkyTheme.warningColor,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _decoration(),
            Utils.mediumVerticalSpacer,
            _buttons(),
          ],
        ),
      );

  Widget _buttons() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
            onPressed: Get.back,
            child: Text(LocaleKeys.setia_module_shared_commons_back.tr),
          ),
          Utils.smallHorizontalSpacer,
          _submitButton()
        ],
      );

  Widget _submitButton() => Obx(
        () => SetiyaElevatedButton(
          onPressed: controller.onAnswerDialogSubmitButtonTap,
          showLoading: controller.isLoading.value,
          child: Text(LocaleKeys.setia_module_shared_commons_register.tr),
        ),
      );

  Widget _decoration() => DecoratedBox(
        decoration: BoxDecoration(
          color: CustomMilkyTheme.primaryColor.shade300,
          borderRadius: BorderRadius.circular(
            CustomMilkyTheme.borderRadiusSemiRound,
          ),
        ),
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LocaleKeys
                    .setia_module_pages_management_authorize_request_are_the_displayed_specifications_acceptable_to_you
                    .tr,
              ),
              Utils.smallVerticalSpacer,
              _radiosField(),
            ],
          ),
        ),
      );

  Widget _radiosField() => DecoratedBox(
        decoration: BoxDecoration(
          color: CustomMilkyTheme.secondaryColor,
          borderRadius: BorderRadius.circular(
            CustomMilkyTheme.borderRadiusSemiRound,
          ),
        ),
        child: Padding(
          padding: Utils.tinyPadding,
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _yesRadio(),
                _noRadio(),
              ],
            ),
          ),
        ),
      );

  Widget _noRadio() => Row(
        children: [
          Text(
            LocaleKeys.setia_module_pages_management_authorize_request_no.tr,
          ),
          Radio<bool>(
            value: false,
            groupValue: controller.hasAccepted.value,
            onChanged: (final value) => controller.hasAccepted.value = value!,
          )
        ],
      );

  Widget _yesRadio() => Row(
        children: [
          Text(
            LocaleKeys.setia_module_pages_management_authorize_request_yes.tr,
          ),
          Radio<bool>(
            value: true,
            groupValue: controller.hasAccepted.value,
            onChanged: (final value) => controller.hasAccepted.value = value!,
          )
        ],
      );
}
