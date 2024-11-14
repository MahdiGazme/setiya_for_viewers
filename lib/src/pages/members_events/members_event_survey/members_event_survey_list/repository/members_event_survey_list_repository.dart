import 'package:milky_http_client/milky_http_client.dart';

import '../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../model/members_event_survey_list_view_model.dart';

class MembersEventsSurveyListRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, List<MembersEventSurveyListViewModel>>> getAllEvents(
      final String query) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getAllAvailableEventsForSurvey(query),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        ((result.data as Map<String, dynamic>)['elements'] as List)
            .map(
              (final element) => MembersEventSurveyListViewModel.fromJson(
                element as Map<String, dynamic>,
              ),
            )
            .toList(),
      ),
    );
  }
}
