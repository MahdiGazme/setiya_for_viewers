import 'package:milky_http_client/milky_http_client.dart';

import '../../../infrastructures/commons/repository_urls.dart';
import '../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/shared_user_login_dto.dart';

class SharedLoginRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, String>> logIn(
      final SharedUserLoginDto userLoginInformation) async {
    final resultOrException = await _httpClient.post(RepositoryUrls.login,
        data: userLoginInformation);

    return resultOrException.fold(
      Left.new,
      (final result) => Right(result.data),
    );
  }
}
