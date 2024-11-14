import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../shared/view/widgets/milky_list_view.dart';
import '../../../../shared/view/widgets/no_content_widget.dart';
import '../../controller/authorize_request_list_controller.dart';
import '../../model/authorize_request_list_item_view_model.dart';
import 'authorize_request_list_item.dart';

class RequestList extends GetView<AuthorizeRequestListController> {
  const RequestList({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Obx(
        () => MilkyListView<AuthorizeRequestListItemViewModel>(
          items: controller.listHandler.list,
          emptyWidget: _noContentWidget(),
          showLoading: controller.listHandler.showLoading.value,
          hasMoreData: controller.listHandler.hasMoreData.value,
          onRefresh: controller.onListRefresh,
          onLoadMoreData: () => controller.listHandler.loadMoreData(
            controller.getAllRequests,
          ),
          itemBuilder: (final context, final item, final index) =>
              AuthorizeRequestListItem(
            user: item,
            onItemTap: controller.onListItemTap,
          ),
        ),
      );

  NoContentWidget _noContentWidget() => NoContentWidget(
        message: LocaleKeys
            .setia_module_pages_management_authorize_request_list_no_request.tr,
      );
}
