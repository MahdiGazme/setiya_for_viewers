import 'package:milky_http_client/milky_http_client.dart';

import '../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/dto/add_new_event_dto.dart';

class AddEventRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, int>> postNewEvent(final AddNewEventDto dto) async {
    final resultOrException = await _httpClient.post(
      RepositoryUrls.postNewEvent,
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
