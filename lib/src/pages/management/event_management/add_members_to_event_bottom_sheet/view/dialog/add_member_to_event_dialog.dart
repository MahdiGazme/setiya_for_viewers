import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../../../../shared/view/dialogs/setiya_alert_dialog.dart';
import '../../../../../shared/view/widgets/asset_icon.dart';
import '../../../../../shared/view/widgets/setiya_elevated_button.dart';
import '../../models/members_list_item_for_add_to_event_view_model.dart';

class AddMemberToEventDialog extends StatelessWidget {
  final MembersListItemForAddToEventViewModel item;
  final void Function() onTap;
  final RxBool showLoading;

  const AddMemberToEventDialog({
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
            Utils.smallVerticalSpacer,
            if (item.doesRegisterAnyEventInSameTime) _multiEventAlert(context),
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
        'آیا از افزودن ${item.firstName} ${item.lastName}'
        ' به این رویداد اطمینان دارید؟',
      );

  DecoratedBox _description() => DecoratedBox(
        decoration: _decoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Text(
            LocaleKeys
                .setia_module_pages_management_event_management_add_members_to_event_bottom_sheet_dialog_hint
                .tr,
          ),
        ),
      );

  BoxDecoration _decoration() => BoxDecoration(
        color: CustomMilkyTheme.primaryColor.shade300,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );

  Row _multiEventAlert(final BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: CustomMilkyTheme.warningColor,
          ),
          Utils.smallHorizontalSpacer,
          Expanded(
            child: Text(
              LocaleKeys
                  .setia_module_pages_management_event_management_add_members_to_event_bottom_sheet_member_is_registered_in_another_event_in_same_date
                  .tr,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: CustomMilkyTheme.warningColor,
                  ),
            ),
          ),
        ],
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
          child: const Text('افزودن'),
        ),
      );
}
