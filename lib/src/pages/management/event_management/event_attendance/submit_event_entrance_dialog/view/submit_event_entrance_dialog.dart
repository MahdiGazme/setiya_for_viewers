import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/date_and_time_utils.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../../../../shared/view/dialogs/getx_view.dart';
import '../../../../../shared/view/dialogs/setiya_alert_dialog.dart';
import '../../../../../shared/view/widgets/information_widget_with_icon.dart';
import '../../../../../shared/view/widgets/page_state.dart';
import '../../../../../shared/view/widgets/setia_avatar_selector/views/setia_avatar_selector.dart';
import '../../../../../shared/view/widgets/setiya_elevated_button.dart';
import '../controller/submit_event_entrance_dialog_controller.dart';

class SubmitEventAttendanceDialog
    extends GetxView<SubmitEventAttendanceDialogController> {
  const SubmitEventAttendanceDialog(super.controller, {super.key});

  @override
  Widget build(final BuildContext context) => PageStateProvider(
        state: controller.state,
        page: () => _content(context),
        onRetry: controller.getMemberInformation,
      );

  Widget _content(final BuildContext context) => SetiyaAlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _avatar(),
            Utils.smallVerticalSpacer,
            _name(),
            Utils.mediumVerticalSpacer,
            _details(),
            if (!controller.memberInformation.isEventMember)
              _notEventMemberWarning(context),
            Utils.mediumVerticalSpacer,
            _buttons()
          ],
        ),
      );

  Widget _name() => Text(
        '${controller.memberInformation.firstName} '
        '${controller.memberInformation.lastName}',
      );

  Widget _avatar() => SetiaAvatarSelector(
        avatarId: controller.memberInformation.avatarId,
        size: 90,
        borderRadios: 50,
        selectorMode: false,
      );

  Widget _notEventMemberWarning(final BuildContext context) => Column(
        children: [
          Utils.smallVerticalSpacer,
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: CustomMilkyTheme.dangerColor,
              ),
              Utils.smallHorizontalSpacer,
              _warningText(context),
            ],
          ),
        ],
      );

  Widget _warningText(final BuildContext context) => Expanded(
        child: Text(
          'این عضو در مراسم مورد نظر ثبت نام نکرده است',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: CustomMilkyTheme.dangerColor,
              ),
        ),
      );

  Widget _buttons() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _backButton(),
          Utils.smallHorizontalSpacer,
          _submitButton(),
        ],
      );

  Widget _submitButton() => Obx(
        () => SetiyaElevatedButton(
          onPressed: controller.onSubmitButtonTap,
          showLoading: controller.isLoading.value,
          child: const Text(
            'ثبت ورود',
          ),
        ),
      );

  Widget _backButton() => OutlinedButton(
        onPressed: Get.back,
        child: const Text('بازگشت'),
      );

  Widget _details() => DecoratedBox(
        decoration: BoxDecoration(
          color: CustomMilkyTheme.primaryColor.shade300,
          borderRadius: BorderRadius.circular(
            CustomMilkyTheme.borderRadiusSemiRound,          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _membershipCode(),
              Utils.smallVerticalSpacer,
              _mobileNumber(),
              Utils.smallVerticalSpacer,
              _birthDate(),
            ],
          ),
        ),
      );

  Widget _birthDate() => InformationWidgetWithIcon(
        label: 'تاریخ تولد :',
        iconPath: 'lib/assets/menu_icons/calendar.png',
        value: DateAndTimeUtils.standardIranDateFormat(
          controller.memberInformation.birthDate,
        ),
        crossAxisAlignment: CrossAxisAlignment.center,
      );

  Widget _mobileNumber() => InformationWidgetWithIcon(
        label: 'شماره همراه :',
        iconPath: 'lib/assets/menu_icons/mobile_number.png',
        value: controller.memberInformation.mobileNumber,
        crossAxisAlignment: CrossAxisAlignment.center,
      );

  Widget _membershipCode() => InformationWidgetWithIcon(
        label: 'کد عضویت :',
        iconPath: 'lib/assets/menu_icons/national_id.png',
        value: controller.memberInformation.membershipCode?.toString(),
        crossAxisAlignment: CrossAxisAlignment.center,
      );
}
