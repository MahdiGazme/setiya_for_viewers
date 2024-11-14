import 'package:milky_http_client/milky_http_client.dart';

import '../../../../infrastructures/commons/repository_urls.dart';
import '../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/dto/membership_request_dto.dart';

class MembershipRequestAddRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, String>> postMembershipRequest(
      final MembershipRequestDto dto) async {
    final resultOrException = await _httpClient.patch(
      RepositoryUrls.postMembershipRequest,
      data: dto.toJson(),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(result.data),
    );
  }
}
