import 'package:get/get.dart';

import '../../../shared/models/enums/page_state_enum.dart';
import '../models/news_view_model.dart';
import '../repository/news_preview_repository.dart';

class NewsPreviewController extends GetxController {
  final String newsId = Get.parameters['newsId']!;

  final _repository = NewsPreviewRepository();
  final state = PageStateEnum.loading.obs;
  NewsViewModel? news;

  @override
  Future<void> onInit() async {
    await getNewsDetails(newsId);
    super.onInit();
  }

  Future<void> getNewsDetails(final String newsId) async {
    final resultOrException = await _repository.getNewsDetails(newsId);

    resultOrException.fold(
      (final exception) => state.value = PageStateEnum.retry,
      (final result) {
        news = result;
        state.value = PageStateEnum.success;
      },
    );
  }
}
