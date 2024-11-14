import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../shared/view/widgets/milky_list_view.dart';
import '../../../../../../shared/view/widgets/no_content_widget.dart';
import '../../controller/active_events_controller.dart';
import '../../models/active_events_view_model.dart';
import 'active_events_list_view_item.dart';


class ActiveEventsListview extends GetView<ActiveEventsController> {
  const ActiveEventsListview({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) =>
      Obx(
            () =>
            MilkyListView<ActiveEventsListItemViewModel>(
              items: controller.listHandler.list,
              controller: controller.scrollController,
              emptyWidget: _emptyWidget(),
              itemBuilder: (final context, final item, final index) =>
                  _listViewItem(item),
              showLoading: controller.listHandler.showLoading.value,
              hasMoreData: controller.listHandler.hasMoreData.value,
              onRefresh: controller.onListRefresh,
              onLoadMoreData: () =>
                  controller.listHandler.loadMoreData(
                    controller.getEventsList,
                  ),
            ),
      );

  Widget _listViewItem(final ActiveEventsListItemViewModel item,) =>
      ActiveEventListItem(
        item: item,
        onTap: () => controller.onListItemTap(item.id),
      );

  Widget _emptyWidget() =>
      const NoContentWidget(
        message: 'رویدادی برای نمایش جود ندارد',
      );
}
