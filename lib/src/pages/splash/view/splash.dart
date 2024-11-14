import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../infrastructures/utils/utils.dart';
import '../controller/splash_controller.dart';

class Splash extends GetView<SplashController> {
  const Splash({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => MilkyScaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Obx(
            () => _content(context),
          ),
        ),
      );

  Column _content(final BuildContext context) => Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _logo(),
          _developerLogo(context),
          if (!controller.isNetworkConnected.value) _retry()
        ],
      );

  Widget _retry() => Padding(
        padding: Utils.mediumPadding,
        child: TextButton(
          onPressed: controller.checkConnection,
          child: const Text('تلاش مجدد'),
        ),
      );

  Widget _developerLogo(final BuildContext context) => Image.asset(
    'lib/assets/images/milky_logo.png',
    width: 110,
    package: 'setia_module',
    color: CustomMilkyTheme.accentColor,
  );

  Widget _logo() => Expanded(
        child: Center(
          child: Image.asset(
            'lib/assets/images/logo_secondary.png',
            height: 250,
            width: 250,
            package: 'setia_module',
            color: CustomMilkyTheme.primaryColor,
          ),
        ),
      );


}
