import 'package:milky_http_client/milky_http_client.dart';

import '../../../../infrastructures/commons/repository_urls.dart';
import '../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/dto/membership_request_dto.dart';
import '../models/membership_request_view_model.dart';

class MembershipRequestEditRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, MembershipRequestViewModel>>
      getOldRequestDetails() async {
    final resultOrException =
        await _httpClient.get(RepositoryUrls.getOldMembershipRequestDetails);

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        MembershipRequestViewModel.fromJson(result.data),
      ),
    );
  }

  Future<Either<String, String>> editOldMembershipRequest(
      final MembershipRequestDto dto) async {
    final resultOrException = await _httpClient.patch(
      RepositoryUrls.updateMembershipRequest,
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
