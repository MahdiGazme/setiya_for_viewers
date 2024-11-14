import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../../setia_module.dart';
import '../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../infrastructures/utils/custom_utils.dart';
import '../../../infrastructures/utils/utils.dart';
import '../../shared/view/widgets/scaffold_body_container.dart';
import '../../shared/view/widgets/secondary_app_bar.dart';
import '../../shared/view/widgets/setiya_elevated_button.dart';
import '../controller/login_page_controller.dart';

class LoginPage extends GetView<LoginPageController> {
  const LoginPage({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        appBar: SecondaryAppBar(
          title: Text(LocaleKeys.setia_module_pages_login_title.tr),
        ),
        body: _body(context),
        backgroundColor: CustomMilkyTheme.primaryColor,
      );

  Widget _body(final BuildContext context) => ScaffoldBodyContainer(
        child: Padding(
          padding: Utils.largePadding,
          child: _form(context),
        ),
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
              Utils.smallVerticalSpacer,
              _password(),
              Utils.mediumVerticalSpacer,
              _rememberMe(),
              Utils.giantVerticalSpacer,
              _loginButton(),
              Utils.giantVerticalSpacer,
              _registerTextButton()
            ],
          ),
        ),
      );

  Widget _registerTextButton() => Align(
        alignment: AlignmentDirectional.bottomStart,
        child: TextButton(
          style: const ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.blue)),
          onPressed: () => Get.offAndToNamed(
            SetiaModuleRouteNames.signup,
          ),
          child: Text(
            LocaleKeys.setia_module_pages_login_no_account.tr,
          ),
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
            Text(
              LocaleKeys.setia_module_shared_commons_remember_me.tr,
            ),
          ],
        ),
      );

  Widget _loginButton() => Obx(
        () => SetiyaElevatedButton(
          onPressed: controller.onLoginButtonTap,
          showLoading: controller.isLoggingIn.value,
          child: Text(
            LocaleKeys.setia_module_pages_login_button.tr,
          ),
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
            LocaleKeys
                .setia_module_shared_text_field_valodations_password_validation
                .tr,
          ),
        ),
      );

  InputDecoration _passwordDecoration() => InputDecoration(
        labelText: LocaleKeys.setia_module_pages_login_password.tr,
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

  Widget _username(final BuildContext context) => TextFormField(
        controller: controller.username,
        decoration: InputDecoration(
          label: Text(LocaleKeys.setia_module_shared_commons_nationalcode.tr),
          counterText: '',
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        maxLength: 10,
        validator: (final value) => CustomUtils.nationalCodeValidator(
          value!,
          LocaleKeys
              .setia_module_shared_text_field_valodations_nationalcode_validation
              .tr,
        ),
      );

  Widget _title(final BuildContext context) => Text(
      LocaleKeys
          .setia_module_pages_login_form_title
          .tr,
        style: Theme.of(context).textTheme.titleMedium,
      );
}
