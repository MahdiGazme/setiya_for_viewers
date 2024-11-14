import 'package:milky_http_client/milky_http_client.dart';

import '../../../../infrastructures/commons/repository_urls.dart';
import '../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../model/dto/members_event_submit_request_dto.dart';
import '../model/members_event_details_view_model.dart';

class MembersEventDetailsRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, MembersEventDetailsViewModel>> getEventDetails(
      final String eventId) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getMembersEventDetails(
        eventId,
      ),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        MembersEventDetailsViewModel.fromJson(
          result.data,
        ),
      ),
    );
  }

  Future<Either<String, String>> submitRequest(
      final MemberEventSubmitRequestDto dto, final String eventId) async {
    final resultOrException = await _httpClient.post(
      RepositoryUrls.membersEventSubmitRequest(eventId),
      data: dto,
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        result.data,
      ),
    );
  }
}
