import 'package:milky_http_client/milky_http_client.dart';

import '../../../infrastructures/commons/repository_urls.dart';
import '../../../infrastructures/utils/http_client/http_client_utils.dart';

class SharedRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, String>> uploadImage(final FormData image) async {
    final resultOrException = await _httpClient.post(
      RepositoryUrls.uploadDocumentUrl,
      data: image,
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(result.data),
    );
  }
}
