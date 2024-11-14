import 'package:milky_http_client/milky_http_client.dart';

import '../../../../infrastructures/commons/repository_urls.dart';
import '../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/dto/change_role_dto.dart';
import '../models/member_role_view_model.dart';

class ChangeRoleDialogRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, MemberRoleViewModel>> getCurrentRole(
    final String memberId,
  ) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getCurrentRole(
        memberId,
      ),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        MemberRoleViewModel.fromJson(result.data),
      ),
    );
  }

  Future<Either<String, String>> changeRole(
    final ChangeRoleDto dto,
    final String memberId,
  ) async {
    final resultOrException = await _httpClient.post(
      RepositoryUrls.changeRole(
        memberId,
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
