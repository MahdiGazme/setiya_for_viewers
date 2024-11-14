import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../controller/main_menu_controller.dart';

class AuthorizeAlert extends GetView<MainMenuController> {
  const AuthorizeAlert({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body();

  Widget _body() => Card(
        child: Padding(
          padding: Utils.smallPadding,
          child: Row(
            children: [
              _hint(),
              Utils.smallHorizontalSpacer,
              _authorizeButton()
            ],
          ),
        ),
      );

  Widget _hint() => Expanded(
        child: Text(
          LocaleKeys.setia_module_pages_main_menu_authorize_alert.tr,
          style: TextStyle(
            color: CustomMilkyTheme.warningColor,
          ),
        ),
      );

  Widget _authorizeButton() => OutlinedButton(
        onPressed: controller.onAuthorizeButtonTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.person_search_outlined),
            Utils.smallHorizontalSpacer,
            Text(LocaleKeys.setia_module_pages_main_menu_autorize_button.tr),
          ],
        ),
      );
}
