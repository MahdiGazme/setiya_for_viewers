import 'package:milky_http_client/milky_http_client.dart';

import '../../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/active_events_view_model.dart';

class ActiveEventsRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, List<ActiveEventsListItemViewModel>>>
      getAllActiveEvents(final String query) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getAllActiveEvents(query),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        ((result.data as Map<String, dynamic>)['elements'] as List)
            .map(
              (final element) => ActiveEventsListItemViewModel.fromJson(
                element as Map<String, dynamic>,
              ),
            )
            .toList(),
      ),
    );
  }
}
