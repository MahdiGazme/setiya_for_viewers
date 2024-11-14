import 'package:get/get.dart';

import '../../../../../setia_module.dart';
import '../../../../infrastructures/utils/list_view_handler.dart';
import '../../../shared/models/enums/page_state_enum.dart';
import '../models/news_list_item_view_model.dart';
import '../repository/news_list_repository.dart';

class NewsListController extends GetxController {
  final _repository = NewsListRepository();

  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;

  final newsListHandler =
      ListViewHandler<NewsListItemViewModel>(hasPagination: true);

  @override
  Future<void> onInit() async {
    await getAllNews();
    super.onInit();
  }

  Future<void> getAllNews() async {
    state.value = PageStateEnum.loading;
    final resultOrException = await _repository.getAllNews(
      newsListHandler.query,
    );
    resultOrException.fold(
      (final exception) {
        if (newsListHandler.list.isEmpty) {
          state.value = PageStateEnum.retry;
        }
      },
      (final result) {
        newsListHandler.onSuccess(
          items: result,
        );
        state.value = PageStateEnum.success;
      },
    );
  }

  Future<void> onRetry() async {
    state.value = PageStateEnum.loading;
    await getAllNews();
  }

  Future<void> onListRefresh() async {
    newsListHandler.prePair(showLoading: true);
    await getAllNews();
  }

  void onListItmTap(final int newsId) {
    Get.toNamed(
      SetiaModuleRouteNames.newsPreview,
      parameters: {'newsId': newsId.toString()},
    );
  }
}
