import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/view/widgets/milky_list_view.dart';
import '../../../../../shared/view/widgets/no_content_widget.dart';
import '../../controller/manage_event_participants_controller.dart';
import '../../models/manage_event_participants_view_model.dart';
import 'manage_event_participants_list_item.dart';

class ManageEventParticipantsListView
    extends GetView<ManageEventParticipantsController> {
  const ManageEventParticipantsListView({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Obx(
        () => MilkyListView<ManageEventParticipantViewModel>(
          items: controller.listHandler.list,
          controller: controller.scrollController,
          emptyWidget: _emptyWidget(),
          itemBuilder: (final context, final item, final index) =>
              _listViewItem(item),
          showLoading: controller.listHandler.showLoading.value,
          hasMoreData: controller.listHandler.hasMoreData.value,
          onRefresh: controller.onListRefresh,
          onLoadMoreData: () => controller.listHandler.loadMoreData(
            controller.getAllEventParticipants,
          ),
        ),
      );

  Widget _listViewItem(
    final ManageEventParticipantViewModel item,
  ) =>
      ManageEventParticipantsListItem(
        item: item,
        onItemTap: () => controller.onEventParticipantTap(item),
        onItemLongTap: controller.onEventParticipantLongTap,
      );

  Widget _emptyWidget() => const NoContentWidget(
        message: 'شرکت کننده ای برای نمایش جود ندارد',
      );
}
