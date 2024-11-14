import 'package:milky_http_client/milky_http_client.dart';

import '../../../../infrastructures/commons/repository_urls.dart';
import '../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/authorize_request_view_model.dart';
import '../models/dto/authorize_request_answer_dto.dart';

class AuthorizeRequestRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, AuthorizeRequestViewModel>> getRequest(
      final String requestId) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getAuthorizeRequest(requestId),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        AuthorizeRequestViewModel.fromJson(
          result.data,
        ),
      ),
    );
  }

  Future<Either<String, String>> postAnswer({
    required final String requestId,
    required final AuthorizeRequestAnswerDto dto,
  }) async {
    final resultOrException = await _httpClient.post(
      RepositoryUrls.postAuthorizeRequestAnswer(
        requestId,
      ),
      data: dto,
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(result.data),
    );
  }
}
