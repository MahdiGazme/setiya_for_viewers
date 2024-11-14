import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../infrastructures/utils/utils.dart';
import '../../shared/view/widgets/asset_icon.dart';
import '../../shared/view/widgets/logo.dart';
import '../../shared/view/widgets/scaffold_body_container.dart';
import '../../shared/view/widgets/secondary_app_bar.dart';
import '../controller/contact_us_controller.dart';

class ContactUs extends GetView<ContactUsController> {
  const ContactUs({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        appBar: const SecondaryAppBar(
          title: Text('تماس با ما'),
        ),
        backgroundColor: CustomMilkyTheme.primaryColor,
        body: _body(context),
      );

  Widget _body(final BuildContext context) => ScaffoldBodyContainer(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Utils.giantVerticalSpacer,
              _logo(),
              Utils.mediumVerticalSpacer,
              _title(context),
              Utils.giantVerticalSpacer,
              _buttons(context),
              Utils.giantVerticalSpacer,
              Utils.giantVerticalSpacer,
              _developerLogo(context),
            ],
          ),
        ),
      );

  Widget _logo() => GestureDetector(
        onLongPress: controller.onSetiyaLogoLongPress,
        child: SetiaLogo(
          size: 180,
          color: CustomMilkyTheme.primaryColor,
        ),
      );

  Widget _title(final BuildContext context) => Text(
        'تشکل دخترانه ستیا',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: CustomMilkyTheme.primaryColor,
            ),
      );

  Widget _buttons(final BuildContext context) => Column(
        children: [
          _managerPhoneNumber(context),
          Utils.smallVerticalSpacer,
          _publicPhoneNumber(context),
          Utils.smallVerticalSpacer,
          _instagram(context),
          Utils.smallVerticalSpacer,
          _email(context),
        ],
      );

  Widget _developerLogo(final BuildContext context) => GestureDetector(
        onTap: controller.onDeveloperLogTap,
        child: Image.asset(
          'lib/assets/images/milky_logo.png',
          width: 110,
          package: 'setia_module',
          color: CustomMilkyTheme.accentColor,
        ),
      );

  Widget _email(final BuildContext context) => _contactUsElement(
        context,
        onTap: controller.onEmailButtonTap,
        path: 'lib/assets/menu_icons/email.png',
        value: 'td.setiya.ir@gmail.com',
      );

  Widget _instagram(final BuildContext context) => _contactUsElement(
        context,
        onTap: controller.onInstagramLinkTap,
        path: 'lib/assets/menu_icons/instagram.png',
        value: '@td.setiya',
      );

  Widget _publicPhoneNumber(final BuildContext context) => _contactUsElement(
        context,
        onTap: controller.onPublicPhoneButtonTap,
        path: 'lib/assets/menu_icons/call.png',
        value: '(روابط عمومی)  +989036538676',
      );

  Widget _managerPhoneNumber(final BuildContext context) => _contactUsElement(
    context,
    onTap: controller.onManagerPhoneButtonTap,
    path: 'lib/assets/menu_icons/call.png',
    value: '(مدیریت)  +989016604280',
  );

  Widget _contactUsElement(
    final BuildContext context, {
    required final String path,
    required final String value,
    required final void Function() onTap,
  }) =>
      InkWell(
        onTap: onTap,
        child: Row(
          children: [
            AssetIcon(
              path: path,
              size: 40,
            ),
            Utils.smallHorizontalSpacer,
            Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge,
              textDirection: TextDirection.ltr,
            ),
          ],
        ),
      );
}
