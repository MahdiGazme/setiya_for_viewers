import 'package:milky_http_client/milky_http_client.dart';

import '../../../../infrastructures/commons/repository_urls.dart';
import '../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../../../shared/models/members_event_history_details_view_model.dart';

class ChildrenEventHistoryDetailsRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, MembersEventHistoryDetailsViewModel>> getEventDetails(
    final String eventId,
    final String childId,
  ) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getChildEventHistoryDetails(
        eventId,
        childId,
      ),
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
}
