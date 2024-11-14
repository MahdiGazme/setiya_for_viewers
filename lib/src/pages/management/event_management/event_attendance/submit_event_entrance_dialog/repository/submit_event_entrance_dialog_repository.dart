import 'package:milky_http_client/milky_http_client.dart';

import '../../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/event_attendance_member_view_model.dart';

class SubmitEventAttendanceDialogRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, EventAttendanceMemberViewModel>>
  getMemberInformationById(
      final String id,
      final String eventId,
      ) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getEventMemberById(
        id,
        eventId,
      ),
    );

    return resultOrException.fold(
      Left.new,
          (final result) => Right(
        EventAttendanceMemberViewModel.fromJson(
          result.data,
        ),
      ),
    );
  }

  Future<Either<String, EventAttendanceMemberViewModel>>
  getMemberInformationByMembershipCode(
      final String membershipCode,
      final String eventId,
      ) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getEventMemberByMembershipCode(
        membershipCode,
        eventId,
      ),
    );

    return resultOrException.fold(
      Left.new,
          (final result) => Right(
        EventAttendanceMemberViewModel.fromJson(
          result.data,
        ),
      ),
    );
  }

  Future<Either<String, String>> submitEventAttendance(
      final String eventId,
      final String memberId,
      ) async {
    final resultOrException = await _httpClient.post(
      RepositoryUrls.submitEventAttendance(
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
