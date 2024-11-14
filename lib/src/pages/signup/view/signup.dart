import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../infrastructures/utils/custom_utils.dart';
import '../../../infrastructures/utils/utils.dart';
import '../../shared/view/widgets/scaffold_body_container.dart';
import '../../shared/view/widgets/secondary_app_bar.dart';
import '../../shared/view/widgets/setiya_elevated_button.dart';
import '../controller/signup_controller.dart';
import 'widget/agree_to_roles.dart';

class Signup extends GetView<SignupController> {
  const Signup({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        appBar: _appBar(),
        backgroundColor: CustomMilkyTheme.primaryColor,
        body: _body(context),
      );

  Widget _body(final BuildContext context) => ScaffoldBodyContainer(
        child: Padding(
          padding: Utils.largePadding,
          child: _form(context),
        ),
      );

  SecondaryAppBar _appBar() => const SecondaryAppBar(
        title: Text('ثبت نام'),
      );

  Widget _form(final BuildContext context) => Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Utils.mediumVerticalSpacer,
              _title(context),
              Utils.largeVerticalSpacer,
              _username(context),
              Utils.mediumVerticalSpacer,
              _password(),
              Utils.smallVerticalSpacer,
              _repeatPassword(),
              Utils.mediumVerticalSpacer,
              _rememberMe(),
              _rules(),
              Utils.giantVerticalSpacer,
              _signupButton(),
            ],
          ),
        ),
      );

  Widget _rules() => Obx(
        () => AgreeToRoles(
          onRulesTap: controller.onRulesTap,
          onChanged: (final val) => controller.isAgreedToRules.value = val,
          isAgreed: controller.isAgreedToRules.value,
        ),
      );

  Widget _rememberMe() => Obx(
        () => Row(
          children: [
            Checkbox(
              value: controller.hasRememberMe.value,
              onChanged: (final value) =>
                  controller.hasRememberMe.value = value!,
            ),
            Utils.tinyHorizontalSpacer,
            const Text('مرا به خاطر بسپار'),
          ],
        ),
      );

  Widget _signupButton() => Obx(
        () => SetiyaElevatedButton(
          onPressed: controller.onSignupButtonTap,
          showLoading: controller.isSigning.value,
          child: const Text('ثبت نام'),
        ),
      );

  Widget _password() => Obx(
        () => TextFormField(
          decoration: _passwordDecoration(),
          obscureText: controller.isPasswordHide.value,
          maxLength: 20,
          controller: controller.password,
          validator: (final value) => CustomUtils.passwordValidator(
            value!,
            'کلمه عبور باید شامل ۸ تا ۱۲ کاراکتر بدون فاصله باشد',
          ),
        ),
      );

  InputDecoration _passwordDecoration() => InputDecoration(
        labelText: 'کلمه عبور',
        counterText: '',
        suffixIcon: IconButton(
          onPressed: () => controller.isPasswordHide.value =
              !controller.isPasswordHide.value,
          icon: Icon(
            Icons.visibility,
            color: controller.isPasswordHide.value
                ? CustomMilkyTheme.disabledColor
                : CustomMilkyTheme.primaryColor,
          ),
        ),
      );

  Widget _repeatPassword() => Obx(
        () => TextFormField(
          decoration: _reportPasswordDecoration(),
          obscureText: controller.isRepeatPasswordHide.value,
          maxLength: 20,
          controller: controller.repeatPassword,
          validator: (final value) => CustomUtils.repeatPasswordValidator(
            value!,
            controller.repeatPassword.text,
            'تکرار کلمه عبور یکسان نیست',
          ),
        ),
      );

  InputDecoration _reportPasswordDecoration() => InputDecoration(
        labelText: 'تکرار کلمه عبور',
        counterText: '',
        suffixIcon: IconButton(
          onPressed: () => controller.isRepeatPasswordHide.value =
              !controller.isRepeatPasswordHide.value,
          icon: Icon(
            Icons.visibility,
            color: controller.isRepeatPasswordHide.value
                ? CustomMilkyTheme.disabledColor
                : CustomMilkyTheme.primaryColor,
          ),
        ),
      );

  Widget _username(final BuildContext context) => TextFormField(
        controller: controller.username,
        decoration: const InputDecoration(
          label: Text('کد ملی'),
          counterText: '',
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        maxLength: 10,
        validator: (final value) => CustomUtils.nationalCodeValidator(
          value!,
          'کد ملی معتبر نمی باشد',
        ),
      );

  Widget _title(final BuildContext context) => Text(
        'ثبت نام ستیا',
        style: Theme.of(context).textTheme.titleMedium,
      );
}
