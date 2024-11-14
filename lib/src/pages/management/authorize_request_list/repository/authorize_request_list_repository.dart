import 'package:milky_http_client/milky_http_client.dart';

import '../../../../infrastructures/commons/repository_urls.dart';
import '../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../model/authorize_request_list_item_view_model.dart';

class AuthorizeRequestListRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, List<AuthorizeRequestListItemViewModel>>>
      getAllRequests(final String query) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getAllAuthorizeRequests(query),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        ((result.data as Map)['elements'] as List)
            .map(
              (final element) => AuthorizeRequestListItemViewModel.fromJson(
                element as Map<String, dynamic>,
              ),
            )
            .toList(),
      ),
    );
  }
}
