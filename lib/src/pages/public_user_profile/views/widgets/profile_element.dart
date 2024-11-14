import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/token/token_info.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/view/widgets/setia_avatar_selector/views/setia_avatar_selector.dart';
import '../../controller/public_profile_controller.dart';
import 'profile_information.dart';

class ProfileElement extends GetView<PublicProfileController> {
  const ProfileElement({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => Card(
        shape: _profileElementShape(),
        child: Padding(
          padding: Utils.smallPadding,
          child: _profileElementContent(context),
        ),
      );

  Widget _profileElementContent(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _avatarAndName(context),
          const SizedBox(
            height: 64,
          ),
          ProfileInformation(
            profileData: controller.profileData!,
          ),
        ],
      );

  RoundedRectangleBorder _profileElementShape() => const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(
            CustomMilkyTheme.borderRadiusSemiRound,
          ),
          bottomStart: Radius.circular(
            CustomMilkyTheme.borderRadiusSemiRound,
          ),
          topEnd: Radius.circular(
            CustomMilkyTheme.borderRadiusSemiRound,
          ),
          topStart: Radius.circular(50),
        ),
      );

  Widget _avatarAndName(final BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _avatar(),
          Utils.smallHorizontalSpacer,
          _nameAndRole(context),
        ],
      );

  Widget _nameAndRole(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _name(context),
          Utils.smallVerticalSpacer,
          _roleWidget(context),
          Utils.tinyVerticalSpacer,
          _membershipCode(context),
        ],
      );

  Widget _membershipCode(final BuildContext context) => Text(
        'کد عضویت: ${controller.profileData!.memberShipCode ?? 'ثبت نشده'}',
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: CustomMilkyTheme.infoColor, fontSize: 10),
      );

  Widget _roleWidget(final BuildContext context) => DecoratedBox(
        decoration: _roleWidgetDecoration(),
        child: Padding(
          padding: Utils.tinyPadding,
          child: Text(
            'سمت کاربر: ${TokenInfo.roles.first.name}',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: CustomMilkyTheme.primaryColor.shade500, fontSize: 10),
          ),
        ),
      );

  BoxDecoration _roleWidgetDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 1,
          color: CustomMilkyTheme.primaryColor.shade500,
        ),
      );

  Widget _name(final BuildContext context) => Text(
        '${controller.profileData!.firstName} '
        '${controller.profileData!.lastName}',
        style: Theme.of(context).textTheme.titleMedium,
      );

  Widget _avatar() => Obx(
        () => SetiaAvatarSelector(
          avatarId: controller.avatarId.value,
          size: 100,
          borderRadios: 50,
          selectorMode: true,
          onDelete: controller.onAvatarDeleted,
          onUploadDone: controller.onAvatarUploaded,
        ),
      );
}
