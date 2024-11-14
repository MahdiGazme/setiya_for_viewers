import 'package:milky_http_client/milky_http_client.dart';
import '../../../../infrastructures/commons/repository_urls.dart';
import '../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../../../shared/models/members_list_item_view_model.dart';

class MembersRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, List<MembersListItemViewModel>>> getAllNormalUsers(
      {final String? query}) async {
    final resultOrException =
        await _httpClient.get(RepositoryUrls.getAllMembers(query));

    return resultOrException.fold(
      Left.new,
      (final result) {
        final elements =
            ((result.data as Map<String, dynamic>)['elements'] as List)
                .map(
                  (final element) => MembersListItemViewModel.fromJson(
                      element as Map<String, dynamic>),
                )
                .toList();

        return Right(elements);
      },
    );
  }
}
