import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../../../../shared/view/dialogs/setiya_alert_dialog.dart';
import '../../../../../shared/view/widgets/asset_icon.dart';
import '../../../../../shared/view/widgets/setiya_elevated_button.dart';
import '../../../controller/members_event_details_controller.dart';

class MemberEventSubmitDialog extends GetView<MembersEventDetailsController> {
  const MemberEventSubmitDialog({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => SetiyaAlertDialog(
        icon: const Align(
          child: AssetIcon(
            path: 'lib/assets/menu_icons/query.png',
            size: 50,
          ),
        ),
        title: _title(),
        content: _content(),
      );

  Widget _content() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [_coloredBox(), Utils.smallVerticalSpacer, _buttons()],
      );

  Widget _buttons() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _backButton(),
          Utils.smallHorizontalSpacer,
          _submitButton(),
        ],
      );

  Widget _backButton() => OutlinedButton(
        onPressed: Get.back,
        child: const Text(
          'بازگشت',
        ),
      );

  Widget _submitButton() => Obx(
        () => SetiyaElevatedButton(
          onPressed: controller.sentSubmitRequest,
          showLoading: controller.isLoading.value,
          child: const Text(
            'ثبت نام',
          ),
        ),
      );

  Widget _coloredBox() => DecoratedBox(
        decoration: _decoration(),
        child: _description(),
      );

  Widget _description() => const Padding(
        padding: Utils.smallPadding,
        child: Text(
          'بعدا می توانید از شرکت در این مراسم انصراف دهید.',
        ),
      );

  BoxDecoration _decoration() => BoxDecoration(
        color: CustomMilkyTheme.primaryColor.shade300,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );

  Widget _title() => const Text('از ثبت نام در این مراسم اطمینان دارید؟');
}
