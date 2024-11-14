import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/view/widgets/setia_avatar_selector/views/setia_avatar_selector.dart';
import '../../../shared/membership_request_child_information_view_model.dart';
import '../../controllers/membership_request_base_controller.dart';

class MembershipRequestFormChildrenField<
    T extends MembershipRequestBaseController> extends GetView<T> {
  const MembershipRequestFormChildrenField({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => DecoratedBox(
        decoration: _mainContainerDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            children: [
              _hint(context),
              Utils.smallVerticalSpacer,
              _childrenListField()
            ],
          ),
        ),
      );

  Widget _childrenListField() => DecoratedBox(
        decoration: _childrenListDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            children: [
              _titleAndAddButton(),
              _childrenList(),
            ],
          ),
        ),
      );

  Widget _titleAndAddButton() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [const Text('فرزندان :'), _addChildButton()],
      );

  Widget _addChildButton() => TextButton(
        onPressed: controller.onAddChildButtonTap,
        child: const Row(
          children: [
            Text('افزودن'),
            Icon(
              Icons.add,
              size: 20,
            ),
          ],
        ),
      );

  Widget _hint(final BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: CustomMilkyTheme.textColor,
            size: 22,
          ),
          Utils.smallHorizontalSpacer,
          _hintText(context),
        ],
      );

  Widget _hintText(final BuildContext context) => Expanded(
        child: Text(
          'در صورتی که به '
          'عنوان مادر اعضای ستیا از نرم افزار '
          'استفاده میکنید این بخش مخصوص شماست',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );

  BoxDecoration _mainContainerDecoration() => BoxDecoration(
        color: CustomMilkyTheme.warningColor,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );

  Widget _childrenList() => Obx(
        () => Column(
          children: controller.children.map(_childrenWidget,).toList(),
        ),
      );

  Widget _childrenWidget(
          final MembershipRequestChildInformationViewModel item) =>
      Card(
        child: Padding(
          padding: Utils.smallPadding,
          child: Row(
            children: [
              _childAvatar(),
              Utils.smallHorizontalSpacer,
              Expanded(
                child: Text(
                  item.nationalCode,
                ),
              ),
              _childRemoveButton(item)
            ],
          ),
        ),
      );

  Widget _childRemoveButton(
          final MembershipRequestChildInformationViewModel item) =>
      IconButton(
        onPressed: () => controller.onRemoveChildTap(
          item.id,
        ),
        icon: const Icon(
          Icons.close,
        ),
        padding: EdgeInsets.zero,
        iconSize: 20,
        color: CustomMilkyTheme.dangerColor,
      );

  Widget _childAvatar() =>
      SetiaAvatarSelector(
        avatarId: null,
        selectorMode: false,
        borderRadios: 10,
        size: 45,
      );

  BoxDecoration _childrenListDecoration() => BoxDecoration(
        color: CustomMilkyTheme.backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
      );
}
