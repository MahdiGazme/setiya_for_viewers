import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../../../../shared/view/dialogs/setiya_alert_dialog.dart';
import '../../../../../shared/view/widgets/asset_icon.dart';
import '../../../../../shared/view/widgets/setiya_elevated_button.dart';
import '../../models/manage_event_participants_view_model.dart';

class ConfirmMemberRequestForEventDialog extends StatelessWidget {
  final ManageEventParticipantViewModel item;
  final void Function() onTap;
  final RxBool showLoading;

  const ConfirmMemberRequestForEventDialog({
    required this.item,
    required this.onTap,
    required this.showLoading,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => SetiyaAlertDialog(
        icon: _icon(),
        title: _title(),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _description(),
            Utils.mediumVerticalSpacer,
            _buttons(),
          ],
        ),
      );

  Align _icon() => const Align(
        child: AssetIcon(
          path: 'lib/assets/menu_icons/query.png',
          size: 70,
        ),
      );

  Text _title() => Text(
        'آیا از تایید درخواست ${item.firstName} ${item.lastName}'
        ' برای شرکت در این رویداد اطمینان دارید؟',
      );

  DecoratedBox _description() => DecoratedBox(
        decoration: _decoration(),
        child: const Padding(
          padding: Utils.smallPadding,
          child: Text(
            'در صورت تایید، این'
            ' عضو به لیست شرکت کنندگان افزوده میشود.\n در صورت تجدید نظر '
            'می توانید این عضو را از رویداد حذف کنید',
          ),
        ),
      );

  BoxDecoration _decoration() => BoxDecoration(
        color: CustomMilkyTheme.primaryColor.shade300,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );

  Row _buttons() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _backButton(),
          Utils.smallHorizontalSpacer,
          _addButton(),
        ],
      );

  OutlinedButton _backButton() => OutlinedButton(
        onPressed: Get.back,
        child: const Text(
          'بازگشت',
        ),
      );

  Widget _addButton() => Obx(
        () => SetiyaElevatedButton(
          onPressed: onTap,
          showLoading: showLoading.value,
          child: const Text('تائید'),
        ),
      );
}
