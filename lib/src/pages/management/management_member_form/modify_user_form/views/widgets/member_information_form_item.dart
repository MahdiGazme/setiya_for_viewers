import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../../../../shared/view/widgets/setia_avatar_selector/views/setia_avatar_selector.dart';
import '../../controllers/base_user_controller.dart';
import 'home_information_form.dart';
import 'member_form_children_list.dart';
import 'organization_information_form.dart';
import 'parent_information_form.dart';
import 'personal_information_form.dart';

class MemberInformationForm<T extends BaseUserController> extends GetView<T> {
  const MemberInformationForm({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => _informationForm(context);

  Widget _informationForm(final BuildContext context) => Expanded(
        child: DecoratedBox(
          decoration: _informationFormDecoration(),
          child: Padding(
            padding: Utils.smallPadding,
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: _information(),
              ),
            ),
          ),
        ),
      );

  Widget _information() => Column(
        children: [
          _avatar(),
          Utils.mediumVerticalSpacer,
          PersonalInformationForm<T>(),
          Utils.smallVerticalSpacer,
          OrganizationInformationForm<T>(),
          Utils.smallVerticalSpacer,
          ParentsInformationForm<T>(),
          Utils.smallVerticalSpacer,
          MemberFormChildrenList<T>(),
          Utils.smallVerticalSpacer,
          HomeInformationForm<T>(),
        ],
      );

  Widget _avatar() => Obx(
        () => SetiaAvatarSelector(
          avatarId: controller.avatarId.value,
          selectorMode: true,
          onDelete: controller.onAvatarDeleted,
          onUploadDone: (final avatarId) {
            controller.avatarId.value = avatarId;
          },
          size: 100,
          borderRadios: 50,
        ),
      );

  BoxDecoration _informationFormDecoration() => BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            CustomMilkyTheme.borderRadiusSemiRound,          ),
        ),
        color: CustomMilkyTheme.secondaryColor,
        boxShadow: [
          BoxShadow(
            color: CustomMilkyTheme.accentColor.withOpacity(0.2),
            offset: const Offset(1, 2),
            blurRadius: 4,
          ),
        ],
      );
}
