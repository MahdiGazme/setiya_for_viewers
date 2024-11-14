import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/view/widgets/milky_list_view.dart';
import '../../../../../shared/view/widgets/no_content_widget.dart';
import '../../controller/members_event_survey_list_controller.dart';
import '../../model/members_event_survey_list_view_model.dart';
import 'members_event_survey_list_item.dart';

class MembersEventSurveyListView
    extends GetView<MembersEventSurveyListController> {
  const MembersEventSurveyListView({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Obx(
        () => MilkyListView<MembersEventSurveyListViewModel>(
          items: controller.listHandler.list,
          emptyWidget: _emptyWidget(),
          itemBuilder: (final context, final item, final index) =>
              _listViewItem(item),
          showLoading: controller.listHandler.showLoading.value,
          hasMoreData: controller.listHandler.hasMoreData.value,
          onRefresh: controller.onListRefresh,
          onLoadMoreData: () => controller.listHandler.loadMoreData(
            controller.getAvailableEventsList,
          ),
        ),
      );

  Widget _listViewItem(
    final MembersEventSurveyListViewModel item,
  ) =>
      MembersEventSurveyListItem(
        item: item,
        remainingTime: controller.calculateRemainingTime(item.endDate),
        onTap: () => controller.onListItemTap(item.id),
      );

  Widget _emptyWidget() => const NoContentWidget(
        message: 'رویدادی برای نظرسنجی وجود ندارد',
      );
}
