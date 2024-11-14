import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../../../../shared/view/widgets/scaffold_body_container.dart';
import '../../../../../shared/view/widgets/secondary_app_bar.dart';
import '../controller/submit_event_attendance_controller.dart';

class SubmitEventAttendance extends GetView<SubmitEventAttendanceController> {
  const SubmitEventAttendance({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        appBar: _appbar(),
        body: _body(context),
        backgroundColor: CustomMilkyTheme.primaryColor,
      );

  Widget _body(final BuildContext context) => ScaffoldBodyContainer(
        child: Padding(
          padding: Utils.mediumPadding,
          child: Center(
            child: _decoratedBox(context),
          ),
        ),
      );

  Widget _decoratedBox(final BuildContext context) => DecoratedBox(
        decoration: _containerDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _title(context),
              Utils.smallVerticalSpacer,
              _hintTitle(),
              Utils.smallVerticalSpacer,
              _hint(context),
              Utils.mediumVerticalSpacer,
              _buttons()
            ],
          ),
        ),
      );

  Widget _buttons() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _membershipCodeButton(),
          Utils.smallHorizontalSpacer,
          _qrcodeButton(),
        ],
      );

  Widget _hint(final BuildContext context) => Text(
        ' ۱. دکمه اسکن را لمس کنید '
        'و کد الکترونیکی را در کادر مشخص شده قرار دهید.\n ۲. در'
        ' صورت ممکن نبودن اسکن میتوانید با کد عضویت حضور عضو'
        ' ستیا را در مراسم ثبت کنید.\n ۳. در صورت تایید مشخصات'
        ' نمایش داده شده حضور عضو ستیا در مراسم ثبت خواهد شد.',
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: CustomMilkyTheme.infoColor,
            ),
      );

  Widget _hintTitle() => Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: CustomMilkyTheme.infoColor,
          ),
          Utils.smallHorizontalSpacer,
          const Text('توضیحات:'),
        ],
      );

  Widget _title(final BuildContext context) => Text(
        'اسکن کد الکترونیکی',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      );

  BoxDecoration _containerDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,        ),
        border: Border.all(
          width: 2,
          color: CustomMilkyTheme.primaryColor.shade500,
        ),
      );

  Widget _qrcodeButton() => ElevatedButton(
        onPressed: controller.onScanQrcodeButtonTap,
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('اسکن کد'),
            Utils.tinyHorizontalSpacer,
            Icon(
              Icons.qr_code_2_rounded,
            )
          ],
        ),
      );

  Widget _membershipCodeButton() => OutlinedButton(
        onPressed: controller.onMembershipCodeButtonTap,
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('کد عضویت'),
            Utils.tinyHorizontalSpacer,
            Icon(
              Icons.numbers,
            )
          ],
        ),
      );

  SecondaryAppBar _appbar() => const SecondaryAppBar(
        title: Text('ثبت ورود'),
      );
}
