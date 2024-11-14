import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../shared/view/widgets/milky_list_view.dart';
import '../../../../../shared/view/widgets/no_content_widget.dart';
import '../../controller/add_member_to_event_bottom_sheet_controller.dart';
import '../../models/members_list_item_for_add_to_event_view_model.dart';
import 'add_member_to_event_list_item.dart';

class AddMemberToEventListView
    extends GetView<AddMemberToEventBottomSheetController> {
  const AddMemberToEventListView({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Obx(
        () => MilkyListView<MembersListItemForAddToEventViewModel>(
          items: controller.listHandler.list,
          emptyWidget: _emptyWidget(),
          itemBuilder: (final context, final item, final index) =>
              _listViewItem(item),
          showLoading: controller.listHandler.showLoading.value,
          hasMoreData: controller.listHandler.hasMoreData.value,
          onRefresh: controller.onListRefresh,
          onLoadMoreData: () => controller.listHandler.loadMoreData(
            controller.getAllAvailableMembers,
          ),
        ),
      );

  Widget _listViewItem(
    final MembersListItemForAddToEventViewModel item,
  ) =>
      AddMemberToEventListItem(
        item: item,
        onItemTap: () => controller.onMemberTap(item),
      );

  Widget _emptyWidget() => NoContentWidget(
        message: LocaleKeys.setia_module_shared_infos_no_users_to_show.tr,
      );
}
