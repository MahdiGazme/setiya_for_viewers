import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../setia_module.dart';
import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/utils.dart';

class NotConnectedDialog extends StatelessWidget {
  const NotConnectedDialog({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Dialog(
        child: Padding(
          padding: Utils.mediumPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _icon(),
              Utils.largeVerticalSpacer,
              _title(context),
              Utils.mediumVerticalSpacer,
              _description(context),
              Utils.giantVerticalSpacer,
              _buttons()
            ],
          ),
        ),
      );

  Widget _buttons() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _okButton(),
          Utils.smallHorizontalSpacer,
          _offlineEnter(),
        ],
      );

  Widget _okButton() => ElevatedButton(
        onPressed: Get.back,
        child: const Text('متوجه شدم'),
      );

  Widget _offlineEnter() => OutlinedButton(
        onPressed: () => Get.toNamed(
          SetiaModuleRouteNames.qrcode,
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ورود آفلاین'),
            Utils.tinyHorizontalSpacer,
            Icon(
              Icons.qr_code_2_rounded,
            )
          ],
        ),
      );

  Widget _description(final BuildContext context) => Text(
        'ارتباط با سرور ممکن نیست'
        ' برای استفاده از نرم افزار ستیا، به اینترنت متصل شوید',
        style: Theme.of(context).textTheme.bodyMedium,
      );

  Widget _title(final BuildContext context) => Text(
        'شما به اینترنت متصل نیستید',
        style: Theme.of(context).textTheme.titleLarge,
      );

  Widget _icon() => Icon(
        CupertinoIcons.wifi_slash,
        color: CustomMilkyTheme.primaryColor,
        size: 50,
      );
}
