import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/view/widgets/milky_list_view.dart';
import '../../../../shared/view/widgets/no_content_widget.dart';
import '../../controller/news_list_controller.dart';
import '../../models/news_list_item_view_model.dart';
import 'news_list_item.dart';

class NewsListView extends GetView<NewsListController> {
  const NewsListView({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => Obx(
        () => MilkyListView<NewsListItemViewModel>(
          items: controller.newsListHandler.list,
          emptyWidget: _noContentWidget(context),
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

  Widget _listItem(final NewsListItemViewModel item) => NewsListItem(
        item: item,
        onItemTap: () => controller.onListItmTap(item.newsId),
      );

  Widget _noContentWidget(final BuildContext context) => const NoContentWidget(
        message: 'خبری برای نمایش وجود ندارد',
      );
}
