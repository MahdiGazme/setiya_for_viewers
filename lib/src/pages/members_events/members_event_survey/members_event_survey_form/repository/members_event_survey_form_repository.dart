import 'package:milky_http_client/milky_http_client.dart';

import '../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/dto/members_event_survey_form_dto.dart';
import '../models/members_event_survey_form_view_model.dart';

class MembersEventSurveyFormRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, MembersEventSurveyFormViewModel>> getEventDetails(
    final String eventId,
  ) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getEventDetailsForSurvey(eventId),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        MembersEventSurveyFormViewModel.fromJson(
          result.data,
        ),
      ),
    );
  }

  Future<Either<String, String>> postRateAndComment(
    final MembersEventSurveyFormDto dto,
    final String eventId,
  ) async {
    final resultOrException = await _httpClient.post(
      RepositoryUrls.postMemberCommentForEvent(
        eventId,
      ),
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
