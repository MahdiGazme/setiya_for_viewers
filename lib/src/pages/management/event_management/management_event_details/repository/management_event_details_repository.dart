import 'package:milky_http_client/milky_http_client.dart';

import '../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/management_event_details.dart';

class ManagementEventDetailsRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, ManagementEventDetailsViewModel>> getEventDetails(
    final String eventId,
  ) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getManagementEventDetails(
        eventId,
      ),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        ManagementEventDetailsViewModel.fromJson(
          result.data,
        ),
      ),
    );
  }

  Future<Either<String, String>> deleteEvent(
    final String eventId,
  ) async {
    final resultOrException = await _httpClient.delete(
      RepositoryUrls.deleteEvent(eventId),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        result.data,
      ),
    );
  }
}
