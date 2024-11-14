import 'package:milky_http_client/milky_http_client.dart';

import '../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/dto/delete_news_dto.dart';
import '../models/management_news_list_item_view_model.dart';

class ManagementNewsListRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, List<ManagementNewsListItemViewModel>>> getAllNews(
      final String query) async {
    final resultOrException =
        await _httpClient.get(RepositoryUrls.getAllNewsManagement(query));

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        ((result.data as Map)['elements'] as List)
            .map(
              (final element) => ManagementNewsListItemViewModel.fromJson(
                  element as Map<String, dynamic>),
            )
            .toList(),
      ),
    );
  }

  Future<Either<String, String>> deleteNews(final DeleteNewsDto dto) async {
    final resultOrException = await _httpClient.delete(
      RepositoryUrls.deleteNews,
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
