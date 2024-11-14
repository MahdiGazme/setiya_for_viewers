import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../infrastructures/utils/utils.dart';
import '../../shared/view/widgets/scaffold_body_container.dart';
import '../../shared/view/widgets/secondary_app_bar.dart';
import '../controller/qr_code_controller.dart';
import 'widget/no_data_widget.dart';

class Qrcode extends GetView<QrcodeController> {
  const Qrcode({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        appBar: _appBar(),
        backgroundColor: CustomMilkyTheme.primaryColor,
        body: _body(context),
      );

  SecondaryAppBar _appBar() => const SecondaryAppBar(
        title: Text('کد الکترونیکی'),
      );

  Widget _body(final BuildContext context) => ScaffoldBodyContainer(
        child: Obx(
          () => controller.hasData.value
              ? _content(context)
              : NoDataWidget(
                  onLoginButtonTap: controller.onLoginButtonTap,
                ),
        ),
      );

  Widget _content(final BuildContext context) => Padding(
        padding: Utils.mediumPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _hint(context),
            Utils.largeVerticalSpacer,
            _qrcode(),
            Utils.mediumVerticalSpacer,
            const Text(
              'برای برقراری ارتباط کد الکترونیکی را اسکن کنید',
            )
          ],
        ),
      );

  Widget _qrcode() => Card(
        child: Padding(
          padding: Utils.smallPadding,
          child: QrImageView(
            data: controller.qrcodeDate,
            version: QrVersions.auto,
          ),
        ),
      );

  Widget _hint(final BuildContext context) => DecoratedBox(
        decoration: _hintDecoration(),
        child: Padding(
          padding: Utils.mediumPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _hintTitle(context),
              Utils.mediumVerticalSpacer,
              _hintDescription(context),
            ],
          ),
        ),
      );

  Widget _hintDescription(final BuildContext context) => Text(
        'با ورود سریع با کد الکترونیکی'
        ' میتوانید به سادگی حتی وقتی آفلاین هستید '
        'ورود خود را ثبت و از برنامه لذت ببرید.',
        style: Theme.of(
          context,
        ).textTheme.bodySmall!.copyWith(
              color: CustomMilkyTheme.textColor.withOpacity(
                0.7,
              ),
            ),
        textAlign: TextAlign.center,
      );

  Widget _hintTitle(final BuildContext context) => Text(
        'ورود سریع با کد الکترونیکی',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      );

  BoxDecoration _hintDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
        border: Border.all(
          width: 2,
          color: CustomMilkyTheme.primaryColor.shade500,
        ),
      );
}
