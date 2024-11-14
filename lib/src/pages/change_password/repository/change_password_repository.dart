import 'package:milky_http_client/milky_http_client.dart';

import '../../../infrastructures/commons/repository_urls.dart';
import '../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/change_password_dto.dart';

class ChangePasswordRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, String>> changePassword(
      final ChangePasswordDto dto) async {
    final resultOrException = await _httpClient.put(
      RepositoryUrls.changePassword,
      data: dto.toJson(),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(result.data),
    );
  }
}
