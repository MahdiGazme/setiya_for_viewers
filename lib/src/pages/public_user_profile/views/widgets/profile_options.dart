import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../setia_module.dart';
import '../../../../infrastructures/role_management/custom_access_keys.dart';
import '../../../../infrastructures/role_management/setiya_user_access.dart';
import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/view/widgets/rate_icon.dart';
import '../../controller/public_profile_controller.dart';

class ProfileOptions extends GetView<PublicProfileController> {
  const ProfileOptions({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Card(
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (SetiaUserAccess.hasUserAccess(
                SetiaModuleRouteNames.memberEventsHistoryList,
              ))
                _memberEventManagement(),
              if (SetiaUserAccess.hasUserAccess(
                SetiaCustomAccessKeys.editMembershipRequestMenuItemInProfile,
              ))
                _editMembershipRequest(),
              Utils.smallVerticalSpacer,
              if (SetiaUserAccess.hasUserAccess(
                SetiaModuleRouteNames.memberAdditionalInformation,
              ))
                _additionalInformation(context),
              Utils.smallVerticalSpacer,
              _changePassword(),
            ],
          ),
        ),
      );

  Widget _memberEventManagement() => _optionsElement(
        icon: Icons.event_available_outlined,
        title: 'مدیریت رویداد های من',
        onTap: controller.onMemberEventManagementTap,
      );

  Widget _changePassword() => _optionsElement(
        icon: Icons.pattern_rounded,
        title: 'ویرایش کلمه عبور',
        onTap: controller.onChangePasswordTap,
      );

  Widget _editMembershipRequest() => Column(
        children: [
          Utils.smallVerticalSpacer,
          _optionsElement(
            icon: Icons.person_search_rounded,
            title: 'ویرایش درخواست احراز هویت',
            onTap: controller.onEditMembershipRequestTap,
          ),
        ],
      );

  Widget _additionalInformation(final BuildContext context) => Column(
        children: [
          if (!controller.profileData!.additionalInformationCompletedBefore)
            _completeAdditionalInformationAlarm(context),
          _optionsElement(
            icon: Icons.account_circle_outlined,
            title: 'تکمیل اطلاعات',
            onTap: controller.onAdditionalInformationTap,
          ),
        ],
      );

  Widget _completeAdditionalInformationAlarm(final BuildContext context) =>
      DecoratedBox(
        decoration: _completeAdditionalInfoDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RateIcon(
                size: 17,
              ),
              Utils.smallHorizontalSpacer,
              Expanded(
                child: Text(
                  'با تکمیل اطلاعات خود برای '
                  'اولین بار از ۱۰ '
                  'امتیاز به عنوان هدیه برخوردار شوید',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )
            ],
          ),
        ),
      );

  BoxDecoration _completeAdditionalInfoDecoration() => BoxDecoration(
        color: CustomMilkyTheme.warningColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );

  Widget _optionsElement({
    required final IconData icon,
    required final String title,
    required final void Function() onTap,
  }) =>
      InkWell(
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
        onTap: onTap,
        child: Padding(
          padding: Utils.smallPadding,
          child: Row(
            children: [
              Icon(
                icon,
                color: CustomMilkyTheme.accentColor,
              ),
              Utils.smallHorizontalSpacer,
              Text(
                title,
              ),
            ],
          ),
        ),
      );
}
