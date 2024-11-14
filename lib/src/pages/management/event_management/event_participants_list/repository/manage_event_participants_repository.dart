import 'package:milky_http_client/milky_http_client.dart';

import '../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/manage_event_participants_view_model.dart';

class ManageEventParticipantsRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, List<ManageEventParticipantViewModel>>>
      getAllEventParticipants(final String eventId, final String query) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getEventParticipantsForManage(eventId, query),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        ((result.data as Map<String, dynamic>)['elements'] as List)
            .map(
              (final element) => ManageEventParticipantViewModel.fromJson(
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

  Future<Either<String, String>> deleteMemberFromEvent(
      final String eventId, final String memberId) async {
    final resultOrException = await _httpClient.delete(
      RepositoryUrls.deleteMemberFromEvent(eventId, memberId),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(result.data),
    );
  }

  Future<Either<String, String>> acceptMemberRequest(
      final String eventId, final String memberId) async {
    final resultOrException = await _httpClient.post(
      RepositoryUrls.acceptMemberRequestForEvent(
        eventId,
        memberId,
      ),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(result.data),
    );
  }
}
