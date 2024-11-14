import 'package:milky_http_client/milky_http_client.dart';

import '../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/dto/add_management_member_dto.dart';

class AddUserRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, String>> submitUser(final AddManagementMemberDto memberDto) async {

    final resultOrException = await _httpClient.post(
      RepositoryUrls.postMember,
      data: memberDto,
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(result.data),
    );
  }
}
