import 'package:milky_http_client/milky_http_client.dart';

import '../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../../../../shared/models/members_event_list_item_view_model.dart';

class MembersEventsHistoryListRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, List<MembersEventListViewModel>>> getAllEvents(
      final String query) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getAllMemberEventsHistory(query),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        ((result.data as Map<String, dynamic>)['elements'] as List)
            .map(
              (final element) => MembersEventListViewModel.fromJson(
                element as Map<String, dynamic>,
              ),
            )
            .toList(),
      ),
    );
  }
}
