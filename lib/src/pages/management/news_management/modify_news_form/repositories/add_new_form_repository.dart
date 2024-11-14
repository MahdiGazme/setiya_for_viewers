import 'package:milky_http_client/milky_http_client.dart';

import '../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/dto/add_news_dto.dart';


class AddNewsFormRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, String>> postNews(final AddNewsDto dto) async {
    final resultOrException = await _httpClient.post(
      RepositoryUrls.postNews,
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
