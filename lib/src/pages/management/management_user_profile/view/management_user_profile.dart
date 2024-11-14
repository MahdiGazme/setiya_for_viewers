import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../../infrastructures/role_management/custom_access_keys.dart';
import '../../../../infrastructures/role_management/setiya_role_enum.dart';
import '../../../../infrastructures/role_management/setiya_user_access.dart';
import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/view/widgets/Setiya_popup_menu.dart';
import '../../../shared/view/widgets/page_state.dart';
import '../../../shared/view/widgets/scaffold_body_container.dart';
import '../../../shared/view/widgets/secondary_app_bar.dart';
import '../../../shared/view/widgets/setia_avatar_selector/views/setia_avatar_selector.dart';
import '../controller/management_user_profile_controller.dart';
import 'widget/children_information.dart';
import 'widget/home_information.dart';
import 'widget/organization_information.dart';
import 'widget/parents_information.dart';
import 'widget/personal_information.dart';

class ManagementUserProfile extends GetView<ManagementUserProfileController> {

  late final String controllerTag = Get.parameters['userId']!;

   ManagementUserProfile({final Key? key}) : super(key: key);

  @override
  String? get tag => controllerTag ;

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        onWillPop: controller.onWillPop,
        backgroundColor: CustomMilkyTheme.primaryColor,
        appBar: const SecondaryAppBar(
          title: Text('نمایه کاربر'),
        ),
        body: ScaffoldBodyContainer(
          child: _state(context),
        ),
      );

  Widget _state(final BuildContext context) => PageStateProvider(
        state: controller.state,
        page: () => _body(context),
        onRetry: controller.getMember,
      );

  Widget _body(final BuildContext context) => Card(
        child: Padding(
          padding: Utils.smallPadding,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _actions(context),
                _avatar(),
                Utils.smallVerticalSpacer,
                _nameAndPhoneNumber(context),
                Utils.mediumVerticalSpacer,
                PersonalInformation(
                  member: controller.member.value!,
                ),
                Utils.smallVerticalSpacer,
                OrganizationInformation(
                  member: controller.member.value!,
                ),
                Utils.smallVerticalSpacer,
                if (controller.member.value!.role == SetiyaRoleEnum.mother)
                  ChildrenInformation(
                    children: controller.member.value!.children,
                    onChildTap: controller.onChildItemTap,
                  ),
                Utils.smallVerticalSpacer,
                ParentsInformation(
                  member: controller.member.value!,
                ),
                Utils.smallVerticalSpacer,
                HomeInformation(
                  member: controller.member.value!,
                ),
              ],
            ),
          ),
        ),
      );

  Widget _actions(final BuildContext context) => Row(
        children: [
          _phoneButton(),
          _messageButton(),
          _moreOptions(context),
        ],
      );

  Widget _messageButton() => IconButton(
        onPressed: () =>
            controller.onSMSButtonTap(controller.member.value!.mobileNumber),
        icon: Icon(
          Icons.message_rounded,
          color: CustomMilkyTheme.accentColor,
        ),
      );

  Widget _phoneButton() => IconButton(
        onPressed: () =>
            controller.onPhoneButtonTap(controller.member.value!.mobileNumber),
        icon: Icon(
          Icons.call_rounded,
          color: CustomMilkyTheme.accentColor,
        ),
      );

  Widget _nameAndPhoneNumber(final BuildContext context) => Padding(
        padding: Utils.tinyPadding,
        child: Column(
          children: [
            _nameText(context),
            Utils.smallVerticalSpacer,
            _phoneNumber(context),
          ],
        ),
      );

  Widget _phoneNumber(final BuildContext context) => Text(
        '0${controller.member.value!.mobileNumber}',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: CustomMilkyTheme.textColor.withOpacity(0.6),
            ),
      );

  Widget _nameText(final BuildContext context) => Text(
        '${controller.member.value!.firstName} '
        '${controller.member.value!.lastName}',
        style: Theme.of(context).textTheme.titleMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget _moreOptions(final BuildContext context) => Expanded(
        child: Align(
          alignment: AlignmentDirectional.topEnd,
          child: SetiyaPopupMenu<int>(
            onSelected: (final value) => controller.onMenuItemSelected(
              value,
              controller.member.value!.firstName,
              controller.member.value!.lastName,
            ),
            items: [
              if (SetiaUserAccess.hasUserAccess(
                SetiaCustomAccessKeys.editMemberRoleInManagementUserProfile,
              ))
                _accessRoleMenuItem(),
              _resetPasswordMenuItem(),
              _editMenuItem(),
              _deleteMenuItem(),
            ],
          ),
        ),
      );

  PopupMenuItem<int> _deleteMenuItem() => _menuItem(
        Icons.delete,
        'حذف',
        1,
      );

  PopupMenuItem<int> _editMenuItem() => _menuItem(
        Icons.edit,
        'ویرایش',
        0,
      );

  PopupMenuItem<int> _resetPasswordMenuItem() => _menuItem(
        Icons.pattern,
        'بازنشانی کلمه عبور',
        2,
      );

  PopupMenuItem<int> _accessRoleMenuItem() => _menuItem(
        Icons.lock_person_rounded,
        'سطح دسترسی',
        3,
      );

  PopupMenuItem<int> _menuItem(
    final IconData icon,
    final String label,
    final int value,
  ) =>
      PopupMenuItem(
        value: value,
        child: Row(
          children: [
            Icon(
              icon,
              color: CustomMilkyTheme.accentColor,
            ),
            Utils.mediumHorizontalSpacer,
            Text(label),
          ],
        ),
      );

  Widget _avatar() => SetiaAvatarSelector(
        selectorMode: false,
        memberName: '${controller.member.value!.firstName} '
            '${controller.member.value!.lastName}',
        avatarId: controller.member.value!.avatarId,
        borderRadios: CustomMilkyTheme.borderRadiusCircular,
        size: 150,
      );
}
