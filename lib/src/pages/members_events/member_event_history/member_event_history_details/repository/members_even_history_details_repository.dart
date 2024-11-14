import 'package:milky_http_client/milky_http_client.dart';

import '../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../../../../shared/models/members_event_history_details_view_model.dart';

class MemberEventHistoryDetailsRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, MembersEventHistoryDetailsViewModel>> getEventDetails(
      final String eventId) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getMemberEventHistoryDetails(eventId),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        MembersEventHistoryDetailsViewModel.fromJason(
          result.data,
        ),
      ),
    );
  }

  Future<Either<String, String>> cancelEvent(final String eventId) async {
    final resultOrException = await _httpClient.delete(
      RepositoryUrls.cancelMemberEvent(eventId),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        result.data,
      ),
    );
  }
}
