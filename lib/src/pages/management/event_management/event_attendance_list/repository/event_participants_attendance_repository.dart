import 'package:milky_http_client/milky_http_client.dart';

import '../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/event_participants_attendance_view_model.dart';

class EventParticipantsAttendanceRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, List<EventParticipantsAttendanceViewModel>>>
      getAllEventParticipants(final String eventId, final String query) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getEventParticipantsAttendance(eventId, query),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        ((result.data as Map<String, dynamic>)['elements'] as List)
            .map(
              (final element) => EventParticipantsAttendanceViewModel.fromJson(
                element as Map<String, dynamic>,
              ),
            )
            .toList(),
      ),
    );
  }
}
