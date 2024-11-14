import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../shared/models/members_list_item_view_model.dart';
import '../../../../shared/view/widgets/milky_list_view.dart';
import '../../../../shared/view/widgets/no_content_widget.dart';
import '../../../../shared/view/widgets/normal_user_list_item.dart';
import '../../controller/members_controller.dart';

class NormalUsersList extends GetView<MembersController> {
  const NormalUsersList({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => Obx(
        () => MilkyListView<MembersListItemViewModel>(
          items: controller.listViewHandler.list,
          emptyWidget: _noContentWidget(context),
          controller: controller.scrollController,
          showLoading: controller.listViewHandler.showLoading.value,
          hasMoreData: controller.listViewHandler.hasMoreData.value,
          onRefresh: controller.onListRefresh,
          onLoadMoreData: () => controller.listViewHandler.loadMoreData(
            controller.getAllNormalUsers,
          ),
          itemBuilder: (final context, final item, final index) =>
              NormalUserListItem(
            user: item,
                onTap: ()=>controller.onUserItemTap(item.id),
          ),
        ),
      );

  Widget _noContentWidget(final BuildContext context) => NoContentWidget(
        message: LocaleKeys.setia_module_shared_infos_no_users_to_show.tr,
      );
}
