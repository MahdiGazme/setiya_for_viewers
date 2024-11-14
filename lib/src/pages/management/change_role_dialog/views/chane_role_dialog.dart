import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../infrastructures/role_management/setiya_role_enum.dart';
import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/view/dialogs/getx_view.dart';
import '../../../shared/view/dialogs/setiya_alert_dialog.dart';
import '../../../shared/view/widgets/asset_icon.dart';
import '../../../shared/view/widgets/page_state.dart';
import '../../../shared/view/widgets/setiya_elevated_button.dart';
import '../controller/change_role_dialog_controller.dart';

class ChangeRoleDialog extends GetxView<ChangeRoleDialogController> {
  const ChangeRoleDialog(super.controller, {super.key});

  @override
  Widget build(final BuildContext context) => PageStateProvider(
        onRetry: controller.getMemberCurrentRole,
        state: controller.state,
        page: () => _dialogBody(context),
      );

  SetiyaAlertDialog _dialogBody(final BuildContext context) =>
      SetiyaAlertDialog(
        icon: const Align(
          child: AssetIcon(
            path: 'lib/assets/menu_icons/access_key.png',
            size: 50,
          ),
        ),
        title: Text(
          LocaleKeys.setia_module_pages_management_change_role_dialog_title.tr,
        ),
        content: _content(context),
      );

  Widget _content(final BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _hintAndRadios(context),
          Utils.mediumVerticalSpacer,
          _buttons()
        ],
      );

  Widget _buttons() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _backButton(),
          Utils.smallHorizontalSpacer,
          _changeRoleButton()
        ],
      );

  Widget _changeRoleButton() => Obx(
        () => SetiyaElevatedButton(
          onPressed: controller.onChangeRoleButtonTap,
          showLoading: controller.isLoading.value,
          child: Text(
            LocaleKeys.setia_module_shared_commons_edit.tr,
          ),
        ),
      );

  Widget _backButton() => OutlinedButton(
        onPressed: Get.back,
        child: Text(
          LocaleKeys.setia_module_shared_commons_back.tr,
        ),
      );

  Widget _hintAndRadios(final BuildContext context) => DecoratedBox(
        decoration: _mainContainerDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            children: [
              _hint(context),
              Utils.smallVerticalSpacer,
              _radiosContainer(),
            ],
          ),
        ),
      );

  Widget _hint(final BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hintIcon(),
          Utils.smallHorizontalSpacer,
          _hintText(context)
        ],
      );

  Widget _hintIcon() => Icon(
        Icons.info_outline_rounded,
        color: CustomMilkyTheme.accentColor,
        size: 20,
      );

  Widget _hintText(final BuildContext context) => Expanded(
        child: Text(
          LocaleKeys.setia_module_pages_management_change_role_dialog_hint.tr,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );

  Widget _radiosContainer() => DecoratedBox(
        decoration: _radiosContainerDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Obx(
            _radios,
          ),
        ),
      );

  Widget _radios() => Column(
        children: [
          _rolesRadiosWithTitle(
            SetiyaRoleEnum.directorOfPublicRelations.name,
            SetiyaRoleEnum.directorOfPublicRelations,
            controller.role.value!,
          ),
          _rolesRadiosWithTitle(
            SetiyaRoleEnum.mediaManager.name,
            SetiyaRoleEnum.mediaManager,
            controller.role.value!,
          ),
          _rolesRadiosWithTitle(
            SetiyaRoleEnum.mother.name,
            SetiyaRoleEnum.mother,
            controller.role.value!,
          ),
          _rolesRadiosWithTitle(
            SetiyaRoleEnum.setiyaMember.name,
            SetiyaRoleEnum.setiyaMember,
            controller.role.value!,
          ),
        ],
      );

  BoxDecoration _radiosContainerDecoration() => BoxDecoration(
        color: CustomMilkyTheme.secondaryColor,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );

  BoxDecoration _mainContainerDecoration() => BoxDecoration(
        color: CustomMilkyTheme.primaryColor.shade200,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );

  Widget _rolesRadiosWithTitle(
    final String title,
    final SetiyaRoleEnum value,
    final SetiyaRoleEnum groupValue,
  ) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(title),
          Radio<SetiyaRoleEnum>(
            value: value,
            groupValue: groupValue,
            onChanged: (final value) => controller.role(value),
          )
        ],
      );
}
