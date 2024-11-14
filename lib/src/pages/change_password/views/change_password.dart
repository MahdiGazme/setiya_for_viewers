import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../infrastructures/utils/custom_utils.dart';
import '../../../infrastructures/utils/utils.dart';
import '../../shared/view/dialogs/getx_view.dart';
import '../../shared/view/widgets/setiya_elevated_button.dart';
import '../controller/change_password_controller.dart';

class ChangePassword extends GetxView<ChangePasswordController> {
  const ChangePassword(super.controller, {super.key});

  @override
  Widget build(final BuildContext context) => AlertDialog(
        title: Text(
          LocaleKeys
              .setia_module_pages_change_password_change_password_title.tr,
        ),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        icon: Icon(
          Icons.pattern,
          color: CustomMilkyTheme.accentColor,
        ),
        content: _content(context),
      );

  Widget _content(final BuildContext context) => SizedBox(
        width: math.min(MediaQuery.of(context).size.width, 600) - 110,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _form(),
            Utils.smallVerticalSpacer,
            _buttons(),
          ],
        ),
      );

  Widget _buttons() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _backButton(),
          Utils.smallHorizontalSpacer,
          _editButton(),
        ],
      );

  Widget _backButton() => OutlinedButton(
        onPressed: Get.back,
        child: Text(
          LocaleKeys.setia_module_shared_commons_back.tr,
        ),
      );

  Widget _editButton() => Obx(
        () => SetiyaElevatedButton(
          onPressed: controller.onChangePasswordTap,
          showLoading: controller.isLoading.value,
          child: Text(
            LocaleKeys.setia_module_shared_commons_edit.tr,
          ),
        ),
      );

  Widget _form() => DecoratedBox(
        decoration: _formContainerDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _oldPassword(),
                _divider(),
                _newPassword(),
                Utils.smallVerticalSpacer,
                _repeatNewPassword(),
              ],
            ),
          ),
        ),
      );

  Widget _divider() => Divider(
        color: CustomMilkyTheme.accentColor,
        height: 30,
      );

  BoxDecoration _formContainerDecoration() => BoxDecoration(
        color: CustomMilkyTheme.primaryColor.shade300,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );

  Widget _oldPassword() => Obx(
        () => TextFormField(
          decoration: _oldPasswordDecoration(),
          obscureText: controller.isOldPasswordHide.value,
          maxLength: 20,
          controller: controller.oldPassword,
          validator: (final value) => CustomUtils.passwordValidator(
            value!,
            LocaleKeys
                .setia_module_shared_text_field_valodations_password_validation
                .tr,
          ),
        ),
      );

  InputDecoration _oldPasswordDecoration() => InputDecoration(
        labelText: LocaleKeys.setia_module_pages_change_password_old_pasword.tr,
        counterText: '',
        suffixIcon: IconButton(
          onPressed: () => controller.isOldPasswordHide.value =
              !controller.isOldPasswordHide.value,
          icon: Icon(
            Icons.visibility,
            color: controller.isOldPasswordHide.value
                ? CustomMilkyTheme.disabledColor
                : CustomMilkyTheme.primaryColor,
          ),
        ),
      );

  Widget _newPassword() => Obx(
        () => TextFormField(
          decoration: _newPasswordDecoration(),
          obscureText: controller.isNewPasswordHide.value,
          maxLength: 20,
          controller: controller.newPassword,
          validator: (final value) => CustomUtils.passwordValidator(
            value!,
            LocaleKeys
                .setia_module_shared_text_field_valodations_password_validation
                .tr,
          ),
        ),
      );

  InputDecoration _newPasswordDecoration() => InputDecoration(
        labelText:
            LocaleKeys.setia_module_pages_change_password_new_password.tr,
        counterText: '',
        suffixIcon: IconButton(
          onPressed: () => controller.isNewPasswordHide.value =
              !controller.isNewPasswordHide.value,
          icon: Icon(
            Icons.visibility,
            color: controller.isNewPasswordHide.value
                ? CustomMilkyTheme.disabledColor
                : CustomMilkyTheme.primaryColor,
          ),
        ),
      );

  Widget _repeatNewPassword() => Obx(
        () => TextFormField(
          decoration: _reportNewPasswordDecoration(),
          obscureText: controller.isRepeatNewPasswordHide.value,
          maxLength: 20,
          controller: controller.repeatNewPassword,
          validator: (final value) => CustomUtils.repeatPasswordValidator(
            value!,
            controller.repeatNewPassword.text,
            LocaleKeys
              .setia_module_shared_text_field_valodations_passwords_are_not_same
                .tr,
          ),
        ),
      );

  InputDecoration _reportNewPasswordDecoration() => InputDecoration(
        labelText:
            LocaleKeys.setia_module_pages_change_password_repeat_password.tr,
        counterText: '',
        suffixIcon: IconButton(
          onPressed: () => controller.isRepeatNewPasswordHide.value =
              !controller.isRepeatNewPasswordHide.value,
          icon: Icon(
            Icons.visibility,
            color: controller.isRepeatNewPasswordHide.value
                ? CustomMilkyTheme.disabledColor
                : CustomMilkyTheme.primaryColor,
          ),
        ),
      );
}
