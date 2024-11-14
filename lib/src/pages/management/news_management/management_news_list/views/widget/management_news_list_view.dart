import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/view/widgets/milky_list_view.dart';
import '../../../../../shared/view/widgets/no_content_widget.dart';
import '../../controller/management_news_list_controller.dart';
import '../../models/management_news_list_item_view_model.dart';
import 'management_new_list_item.dart';

class ManagementNewsListView extends GetView<ManagementNewsListController> {
  const ManagementNewsListView({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => Obx(
        () => MilkyListView<ManagementNewsListItemViewModel>(
          items: controller.newsListHandler.list(),
          emptyWidget: _noContentWidget(context),
          controller: controller.scrollController,
          showLoading: controller.newsListHandler.showLoading.value,
          hasMoreData: controller.newsListHandler.hasMoreData.value,
          onRefresh: controller.onListRefresh,
          onLoadMoreData: () => controller.newsListHandler.loadMoreData(
            controller.getAllNews,
          ),
          itemBuilder: (final context, final item, final index) =>
              _listItem(item),
        ),
      );

  Widget _listItem(final ManagementNewsListItemViewModel item) => Obx(
        () => ManagementNewsListItem(
          item: item,
          onItemTap: controller.onListItemTap,
          onItemLongPress: controller.onListItemLongPress,
          isSelected: controller.selectedItems.contains(item.newsId),
        ),
      );

  Widget _noContentWidget(final BuildContext context) => const NoContentWidget(
        message: 'خبری برای نمایش وجود ندارد',
      );
}
