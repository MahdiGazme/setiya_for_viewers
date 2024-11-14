import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../../../../shared/view/dialogs/setiya_alert_dialog.dart';
import '../../../../../shared/view/widgets/asset_icon.dart';
import '../../../../../shared/view/widgets/setiya_elevated_button.dart';
import '../../controller/members_event_history_details_controller.dart';

class CancelEventRegistrationDialog
    extends GetView<MembersEventHistoryDetailsController> {
  const CancelEventRegistrationDialog({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => SetiyaAlertDialog(
        icon: _icon(),
        title: _title(),
        content: _content(),
      );

  Widget _title() =>
      const Text('آیا از انصراف از شرکت در رویداد اطمینان دارید؟');

  Widget _icon() => const Align(
        child: AssetIcon(
          path: 'lib/assets/menu_icons/query.png',
          size: 50,
        ),
      );

  Widget _content() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [_hint(), Utils.mediumVerticalSpacer, _buttons()],
      );

  Widget _buttons() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _backButton(),
          Utils.smallHorizontalSpacer,
          _cancelEventRegistrationButton()
        ],
      );

  Widget _cancelEventRegistrationButton() => Obx(
        () => SetiyaElevatedButton(
          onPressed: controller.cancelEvent,
          showLoading: controller.isLoading.value,
          child: const Text('انصراف'),
        ),
      );

  Widget _backButton() => OutlinedButton(
        onPressed: Get.back,
        child: const Text('بازگشت'),
      );

  Widget _hint() => DecoratedBox(
        decoration: _decoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_hintIcon(), Utils.smallHorizontalSpacer, _hintText()],
          ),
        ),
      );

  Widget _hintIcon() => Icon(
        Icons.info_outline_rounded,
        color: CustomMilkyTheme.accentColor,
      );

  Widget _hintText() => const Expanded(
        child: Text('در صورت انصراف باید دوباره '
            'درخواست شما توسط مدیر تایید شود.\nشما می توانید'
            ' در زمانی دیگر دوباره در این رویداد ثبت نام کنید.'),
      );

  BoxDecoration _decoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
        color: CustomMilkyTheme.primaryColor.shade300,
      );
}
