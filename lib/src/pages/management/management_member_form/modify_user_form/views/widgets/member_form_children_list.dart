import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../../../../shared/view/widgets/management_children_list_item.dart';
import '../../controllers/base_user_controller.dart';

class MemberFormChildrenList<T extends BaseUserController> extends GetView<T> {
  const MemberFormChildrenList({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => DecoratedBox(
        decoration: _fieldsDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            children: [
              Text(
                'مشخصات فرزندان',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Utils.smallVerticalSpacer,
              _childrenField()
            ],
          ),
        ),
      );

  Widget _childrenField() => DecoratedBox(
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

  BoxDecoration _childrenListDecoration() => BoxDecoration(
        color: CustomMilkyTheme.backgroundColor,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );

  Widget _titleAndAddButton() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'فرزندان:',
          ),
          _addChildButton(),
        ],
      );

  Widget _childrenList() => Obx(
        () => ListView.builder(
          itemCount: controller.children.length,
          itemBuilder: (final context, final index) =>
              ManagementChildrenListItem(
            child: controller.children[index],
            onTap: null,
          ),
          shrinkWrap: true,
          primary: true,
          padding: EdgeInsets.zero,
        ),
      );

  Widget _addChildButton() => IconButton(
        onPressed: controller.onAddChildButtonTap,
        icon: const Icon(
          Icons.edit,
          size: 20,
        ),
        color: CustomMilkyTheme.primaryColor,
      );

  BoxDecoration _fieldsDecoration() => BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            CustomMilkyTheme.borderRadiusSemiRound,          ),
        ),
        color: CustomMilkyTheme.primaryColor.shade200,
      );
}
