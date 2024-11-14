import 'package:milky_http_client/milky_http_client.dart';

import '../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/members_list_item_for_add_to_event_view_model.dart';

class AddMemberToEventRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, List<MembersListItemForAddToEventViewModel>>>
      getAllAvailableMembers(final String eventId, final String query) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getMembersToAddToEvent(eventId, query),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        ((result.data as Map<String, dynamic>)['elements'] as List)
            .map(
              (final element) => MembersListItemForAddToEventViewModel.fromJson(
                element as Map<String, dynamic>,
              ),
            )
            .toList(),
      ),
    );
  }

  Future<Either<String, String>> addMemberToEvent(
      final String eventId, final String memberId) async {
    final resultOrException = await _httpClient.post(
      RepositoryUrls.addMemberToEvent(eventId, memberId),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(result.data),
    );
  }
}
