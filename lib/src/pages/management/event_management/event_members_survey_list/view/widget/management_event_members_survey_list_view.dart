import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/view/widgets/milky_list_view.dart';
import '../../../../../shared/view/widgets/no_content_widget.dart';
import '../../controller/management_event_members_survey_list_controller.dart';
import '../../models/management_event_members_survey_list_view_model.dart';
import 'management_event_members_survey_list_item.dart';

class ManagementEventMembersSurveyListView
    extends GetView<ManagementEventMembersSurveyListController> {
  const ManagementEventMembersSurveyListView({final Key? key})
      : super(key: key);

  @override
  Widget build(final BuildContext context) => Obx(
        () => MilkyListView<ManagementEventMembersSurveyListViewModel>(
          items: controller.listHandler.list,
          controller: controller.scrollController,
          emptyWidget: _emptyWidget(),
          itemBuilder: (final context, final item, final index) =>
              _listViewItem(item),
          showLoading: controller.listHandler.showLoading.value,
          hasMoreData: controller.listHandler.hasMoreData.value,
          onRefresh: controller.onListRefresh,
          onLoadMoreData: () => controller.listHandler.loadMoreData(
            controller.getEventCommentsList,
          ),
        ),
      );

  Widget _listViewItem(
    final ManagementEventMembersSurveyListViewModel item,
  ) =>
      ManagementEventMembersSurveyListItem(
        item: item,
        onTap: () => controller.onListItemTap(item.commentId),
      );

  Widget _emptyWidget() => const NoContentWidget(
        message: 'بازخوردی برای نمایش وجود ندارد',
      );
}
