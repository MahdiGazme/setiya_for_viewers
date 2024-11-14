import 'package:milky_http_client/milky_http_client.dart';

import '../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../../../../shared/models/member_view_model.dart';
import '../models/dto/edit_management_member_dto.dart';

class EditUserRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, MemberDetailsViewModel>> getUserInformation(
      final String userId) async {
    final resultOrException =
        await _httpClient.get(RepositoryUrls.getMemberDetails(userId));

    return resultOrException.fold(
      Left.new,
      (final result) => Right(MemberDetailsViewModel.fromJson(result.data)),
    );
  }

  Future<Either<String, String>> updateUserInformation(
      final String id, final EditManagementMemberDto data) async {
    final resultOrException = await _httpClient.put(
      RepositoryUrls.patchMember(id),
      data: data,
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(result.data),
    );
  }
}
