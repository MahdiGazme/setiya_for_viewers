import 'package:milky_http_client/milky_http_client.dart';

import '../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/dto/edit_news_dto.dart';
import '../models/management_news_view_model.dart';

class EditNewsFormRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, ManagementNewsViewModel>> getOldNews(
      final String newsId) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getManagementsNewsDetails(newsId),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        ManagementNewsViewModel.fromJson(result.data),
      ),
    );
  }

  Future<Either<String, String>> editNews(
      final String id, final EditNewsDto dto) async {
    final resultOrException = await _httpClient.put(
      RepositoryUrls.editNews(id),
      data: dto.toJson(),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        result.data,
      ),
    );
  }
}
