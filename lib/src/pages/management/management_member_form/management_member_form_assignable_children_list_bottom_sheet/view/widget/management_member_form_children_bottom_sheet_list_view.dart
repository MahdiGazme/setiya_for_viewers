import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/models/management_child_view_model.dart';
import '../../../../../shared/view/widgets/milky_list_view.dart';
import '../../../../../shared/view/widgets/no_content_widget.dart';
import '../../controller/management_member_form_children_bottom_sheet_controller.dart';
import 'management_member_form_children_bottom_sheet_list_item.dart';

class ManagementMemberFormChildrenBottomSheetListView
    extends GetView<ManagementMemberFormChildrenBottomSheetController> {
  const ManagementMemberFormChildrenBottomSheetListView({final Key? key})
      : super(key: key);

  @override
  Widget build(final BuildContext context) => Obx(
        () => MilkyListView<ManagementChildViewModel>(
          items: controller.listHandler.list,
          emptyWidget: _emptyWidget(),
          itemBuilder: (final context, final item, final index) =>
              _listViewItem(item),
          showLoading: controller.listHandler.showLoading.value,
          hasMoreData: controller.listHandler.hasMoreData.value,
          onRefresh: controller.onListRefresh,
          onLoadMoreData: () => controller.listHandler.loadMoreData(
            controller.getAllAssignableChildren,
          ),
        ),
      );

  Widget _listViewItem(
    final ManagementChildViewModel child,
  ) =>
      Obx(
        () => ManagementMemberFormChildrenBottomSheetListItem(
          child: child,
          isChecked: controller.children.any((final e) => e.id == child.id),
          onTap: (final child, final isChecked) =>
              controller.onListItemCheckChanged(
            child,
            isChecked: isChecked,
          ),
        ),
      );

  Widget _emptyWidget() => const NoContentWidget(
        message: 'عضوی برای نمایش وجود ندارد',
      );
}
