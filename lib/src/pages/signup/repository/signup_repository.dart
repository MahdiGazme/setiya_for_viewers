import 'package:milky_http_client/milky_http_client.dart';

import '../../../infrastructures/commons/repository_urls.dart';
import '../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/dto/signup_dto.dart';

class SignupRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, String>> signup(final SignupDto dto) async {
    final resultOrException = await _httpClient.post(
      RepositoryUrls.signup,
      data: dto.toJson(),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(result.data),
    );
  }
}
