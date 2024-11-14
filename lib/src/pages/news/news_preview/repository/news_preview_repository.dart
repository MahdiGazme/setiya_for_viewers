import 'package:milky_http_client/milky_http_client.dart';

import '../../../../infrastructures/commons/repository_urls.dart';
import '../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/news_view_model.dart';

class NewsPreviewRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, NewsViewModel>> getNewsDetails(
      final String newsId) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getNewsDetails(newsId),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        NewsViewModel.fromJson(result.data),
      ),
    );
  }
}
