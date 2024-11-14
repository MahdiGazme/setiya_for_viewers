import 'package:flutter/material.dart';

import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/models/management_child_view_model.dart';
import '../../../../shared/view/widgets/management_children_list_item.dart';
import '../../../../shared/view/widgets/no_content_widget.dart';

class ChildrenInformation extends StatelessWidget {
  final List<ManagementChildViewModel> children;
  final void Function(String id) onChildTap;

  const ChildrenInformation({
    required this.children,
    required this.onChildTap,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => DecoratedBox(
        decoration: _bodyDecoration(),
        child: _bodyItems(context),
      );

  Widget _bodyItems(final BuildContext context) => Padding(
        padding: Utils.smallPadding,
        child: Column(
          children: [
            Text(
              'فرزندان',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Utils.largeVerticalSpacer,
            _childContainer()
          ],
        ),
      );

  Widget _childContainer() => DecoratedBox(
      decoration: _childContainerDecoration(),
      child: Padding(
        padding: Utils.smallPadding,
        child: children.isEmpty ? _noChildrenWidget() : _childrenList(),
      ));

  Widget _noChildrenWidget() => const NoContentWidget(
        message: 'بدون فرزند',
        size: 200,
      );

  BoxDecoration _childContainerDecoration() => BoxDecoration(
        color: CustomMilkyTheme.backgroundColor,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );

  Widget _childrenList() => ListView.builder(
        shrinkWrap: true,
        primary: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: children.length,
        padding: EdgeInsets.zero,
        itemBuilder: (final context, final index) => ManagementChildrenListItem(
          child: children[index],
          onTap: () => onChildTap.call(children[index].id),
        ),
      );

  BoxDecoration _bodyDecoration() => BoxDecoration(
        color: CustomMilkyTheme.primaryColor.shade200,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            CustomMilkyTheme.borderRadiusSemiRound,
          ),
        ),
      );
}
