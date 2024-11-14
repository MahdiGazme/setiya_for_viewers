import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/view/widgets/milky_list_view.dart';
import '../../../../../shared/view/widgets/no_content_widget.dart';
import '../../controller/event_participants_attendance_controller.dart';
import '../../models/event_participants_attendance_view_model.dart';
import 'event_participants_attendance_list_item.dart';

class EventParticipantsAttendanceListView
    extends GetView<EventParticipantAttendanceController> {
  const EventParticipantsAttendanceListView({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Obx(
        () => MilkyListView<EventParticipantsAttendanceViewModel>(
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
    final EventParticipantsAttendanceViewModel item,
  ) =>
      EventParticipantsAttendanceListItem(
        item: item,
        onItemTap: controller.onEventParticipantTap,
      );

  Widget _emptyWidget() => const NoContentWidget(
        message: 'شرکت کننده ای برای نمایش جود ندارد',
      );
}
