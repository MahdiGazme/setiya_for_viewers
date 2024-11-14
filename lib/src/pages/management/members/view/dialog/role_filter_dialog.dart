import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../infrastructures/role_management/setiya_role_enum.dart';
import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/view/dialogs/setiya_alert_dialog.dart';
import '../../../../shared/view/widgets/asset_icon.dart';
import '../../controller/members_controller.dart';

class RoleFilterDialog extends GetView<MembersController> {
  const RoleFilterDialog({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => SetiyaAlertDialog(
        icon: const Align(
          child: AssetIcon(
            path: 'lib/assets/menu_icons/filter.png',
            size: 50,
          ),
        ),
        title: const Text('مرتب سازی بر اساس'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _filters(),
            Utils.mediumVerticalSpacer,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: Get.back,
                  child: const Text('بازگشت'),
                ),
                Utils.smallHorizontalSpacer,
                ElevatedButton(
                  onPressed: controller.onFilterClear,
                  child: const Text('پاکسازی'),
                ),
              ],
            )
          ],
        ),
      );

  Widget _filters() => DecoratedBox(
        decoration: _filtersFieldDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            children: [
              _filterItem(
                SetiyaRoleEnum.directorOfPublicRelations,
              ),
              _filterItem(
                SetiyaRoleEnum.mediaManager,
              ),
              _filterItem(
                SetiyaRoleEnum.mother,
              ),
              _filterItem(
                SetiyaRoleEnum.setiyaMember,
              ),
            ],
          ),
        ),
      );

  BoxDecoration _filtersFieldDecoration() => BoxDecoration(
        color: CustomMilkyTheme.primaryColor.shade300,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );

  Widget _filterItem(final SetiyaRoleEnum role) => Obx(
        () => CheckboxListTile(
          value: controller.roleFilters.contains(
            role.value,
          ),
          onChanged: (final isChecked) => controller.onFilterChecked(
            role.value,
            isChecked: isChecked!,
          ),
          title: Text(
            role.name,
          ),
        ),
      );
}
