import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../setia_module.dart';
import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/utils.dart';

class LoginAlert extends StatelessWidget {
  const LoginAlert({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body();

  Widget _body() => Card(
        child: Padding(
          padding: Utils.smallPadding,
          child: Row(
            children: [
              _loginHint(),
              Utils.smallHorizontalSpacer,
              _loginButton()
            ],
          ),
        ),
      );

  Widget _loginHint() => Expanded(
        child: Text(
          LocaleKeys.setia_module_pages_main_menu_login_alert.tr,
          style: TextStyle(
            color: CustomMilkyTheme.warningColor,
          ),
        ),
      );

  Widget _loginButton() => OutlinedButton(
        onPressed: () => Get.toNamed(SetiaModuleRouteNames.logIn),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.login),
            Utils.smallHorizontalSpacer,
            Text(LocaleKeys.setia_module_pages_main_menu_user_login.tr),
          ],
        ),
      );
}
