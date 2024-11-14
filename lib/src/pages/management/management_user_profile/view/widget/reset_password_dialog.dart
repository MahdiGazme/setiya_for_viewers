import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/view/dialogs/setiya_alert_dialog.dart';
import '../../../../shared/view/widgets/setiya_elevated_button.dart';
import '../../controller/management_user_profile_controller.dart';

class ResetPasswordDialog extends GetView<ManagementUserProfileController> {
  const ResetPasswordDialog({final Key? key}) : super(key: key);

  @override
  String? get tag => Get.parameters['userId']!;

  @override
  Widget build(final BuildContext context) => SetiyaAlertDialog(
        icon: _icon(),
        iconColor: CustomMilkyTheme.warningColor,
        title: const Text('بازنشانی کلمه عبور'),
        content: _content(),
      );

  Widget _content() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [_container(), Utils.largeVerticalSpacer, _buttons()],
      );

  Widget _container() => DecoratedBox(
        decoration: _containerDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: _hint(),
        ),
      );

  Widget _hint() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_hintIcon(), Utils.smallHorizontalSpacer, _hintText()],
      );

  Widget _hintText() => const Expanded(
        child: Text(
          'با بازنشانی کلمه عبور از این پس می بایست کاربر از '
          'شماره تلفن همراه ثبت شده به عنوان کلمه عبور استفاده '
          'نماید، کلمه عبور بعدا قابل ویرایش می باشد',
        ),
      );

  Widget _hintIcon() => Icon(
        Icons.info_outline_rounded,
        color: CustomMilkyTheme.accentColor,
      );

  BoxDecoration _containerDecoration() => BoxDecoration(
        color: CustomMilkyTheme.primaryColor.shade300,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,        ),
      );

  Widget _icon() => const Icon(
        Icons.warning_amber_rounded,
        size: 35,
      );

  Widget _buttons() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _backButton(),
          Utils.smallHorizontalSpacer,
          _resetButton(),
        ],
      );

  Widget _resetButton() => Obx(
        () => SetiyaElevatedButton(
          onPressed: controller.resetPassword,
          showLoading: controller.isLoading.value,
          child: const Text('بازنشانی'),
        ),
      );

  Widget _backButton() => OutlinedButton(
        onPressed: Get.back,
        child: const Text('بازگشت'),
      );
}
