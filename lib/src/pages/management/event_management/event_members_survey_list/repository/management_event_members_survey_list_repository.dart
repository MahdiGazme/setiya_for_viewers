import 'package:milky_http_client/milky_http_client.dart';

import '../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/management_event_members_survey_list_view_model.dart';

class ManagementEventMembersSurveyListRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, List<ManagementEventMembersSurveyListViewModel>>>
      getAllEventComments(
    final String eventId,
    final String query,
  ) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getAllEventCommentsForManagement(
        eventId,
        query,
      ),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        ((result.data as Map<String, dynamic>)['elements'] as List)
            .map(
              (final element) =>
                  ManagementEventMembersSurveyListViewModel.fromJson(
                element as Map<String, dynamic>,
              ),
            )
            .toList(),
      ),
    );
  }
}
