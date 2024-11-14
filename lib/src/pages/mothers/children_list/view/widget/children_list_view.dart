import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/view/widgets/milky_list_view.dart';
import '../../../../shared/view/widgets/no_content_widget.dart';
import '../../controller/children_list_controller.dart';
import '../../models/children_list_item_view_model.dart';
import 'children_list_view_item.dart';

class ChildrenListView extends GetView<ChildrenListController> {
  const ChildrenListView({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Obx(
        () => MilkyListView<ChildrenListItemViewModel>(
          items: controller.listHandler.list,
          emptyWidget: _emptyWidget(),
          itemBuilder: (final context, final item, final index) =>
              _listViewItem(item),
          showLoading: controller.listHandler.showLoading.value,
          hasMoreData: controller.listHandler.hasMoreData.value,
          onRefresh: controller.onListRefresh,
          onLoadMoreData: () => controller.listHandler.loadMoreData(
            controller.getAllChildren,
          ),
        ),
      );

  Widget _listViewItem(
    final ChildrenListItemViewModel item,
  ) =>
      ChildrenListViewItem(
        child: item,
        onTap: () => controller.onChildItemTap(item.id),
      );

  Widget _emptyWidget() => const NoContentWidget(
        message: 'رویدادی برای نمایش جود ندارد',
      );
}
