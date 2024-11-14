import 'package:milky_http_client/milky_http_client.dart';
import '../../../../infrastructures/commons/repository_urls.dart';
import '../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../../../shared/models/member_view_model.dart';

class ManagementUserProfileRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, MemberDetailsViewModel>> getMemberInformation(
    final String id,
  ) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getMemberDetails(id),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        MemberDetailsViewModel.fromJson(result.data),
      ),
    );
  }

  Future<Either<String, String>> deleteMember(
    final String id,
  ) async {
    final resultOrException = await _httpClient.delete(
      RepositoryUrls.deleteMember(id),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(result.data),
    );
  }

  Future<Either<String, String>> resetPassword(
    final String id,
  ) async {
    final resultOrException = await _httpClient.patch(
      RepositoryUrls.resetPassword(id),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        result.data,
      ),
    );
  }
}
