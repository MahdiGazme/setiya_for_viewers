import 'package:milky_http_client/milky_http_client.dart';

import '../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/dto/edit_event_dto.dart';
import '../models/management_event_to_edit_view_model.dart';

class EditEventRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, ManagementEventToEditViewModel>> getEventDetails(
    final String eventId,
  ) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getManagementEventDetails(eventId),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        ManagementEventToEditViewModel.fromJson(
          result.data,
        ),
      ),
    );
  }

  Future<Either<String, String>> patchNewEvent(
    final String eventId,
    final EditNewEventDto dto,
  ) async {
    final resultOrException = await _httpClient.put(
      RepositoryUrls.editEvent(eventId),
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
