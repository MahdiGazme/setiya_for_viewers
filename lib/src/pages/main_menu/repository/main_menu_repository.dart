import 'package:milky_http_client/milky_http_client.dart';

import '../../../infrastructures/commons/repository_urls.dart';
import '../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/authorize_request_status_view_model.dart';
import '../models/news_preview_view_model.dart';

class MainMenuRepository {
  final _httpClient = HttpClientUtils.httpClient();


  Future<Either<String, List<NewsPreviewViewModel>>> getLastNews() async {
    final resultOrException = await _httpClient.get(RepositoryUrls.getLastNews);

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        (result.data as List)
            .map(
              (final element) => NewsPreviewViewModel.fromJson(
                element as Map<String, dynamic>,
              ),
            )
            .toList(),
      ),
    );
  }

  Future<Either<String, AuthorizeRequestStatusViewModel>>
      getAuthorizeRequestStatus() async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.authorizeRequestStatus,
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        AuthorizeRequestStatusViewModel.fromJson(
          result.data,
        ),
      ),
    );
  }
}
