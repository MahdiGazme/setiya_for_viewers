import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/view/widgets/milky_list_view.dart';
import '../../../../../shared/view/widgets/no_content_widget.dart';
import '../../controller/management_events_list_controller.dart';
import '../../models/management_events_list_item_view_model.dart';
import 'management_event_list_item.dart';

class ManagementEventsListView extends GetView<ManagementEventsListController> {
  const ManagementEventsListView({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Obx(
        () => MilkyListView<ManagementEventsListViewModel>(
          items: controller.listHandler.list,
          controller: controller.scrollController,
          emptyWidget: _emptyWidget(),
          itemBuilder: (final context, final item, final index) =>
              _listViewItem(item),
          showLoading: controller.listHandler.showLoading.value,
          hasMoreData: controller.listHandler.hasMoreData.value,
          onRefresh: controller.onListRefresh,
          onLoadMoreData: () => controller.listHandler.loadMoreData(
            controller.getEventsList,
          ),
        ),
      );

  Widget _listViewItem(
    final ManagementEventsListViewModel item,
  ) =>
      ManagementEventListItem(
        item: item,
        onTap: () => controller.onListItemTap(item.id),
      );

  Widget _emptyWidget() => const NoContentWidget(
        message: 'رویدادی برای نمایش جود ندارد',
      );
}
