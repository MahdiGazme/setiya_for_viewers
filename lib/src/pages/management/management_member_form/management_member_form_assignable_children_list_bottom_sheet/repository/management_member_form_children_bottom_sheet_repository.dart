import 'package:milky_http_client/milky_http_client.dart';

import '../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../../../../shared/models/management_child_view_model.dart';

class ManagementMemberFormChildrenBottomSheetRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, List<ManagementChildViewModel>>>
      getAllAssignableChildren(
    final String query,
  ) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getAllAssignableChildren(
        query,
      ),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        ((result.data as Map)['elements'] as List)
            .map(
              (final element) => ManagementChildViewModel.fromJson(
                  element as Map<String, dynamic>),
            )
            .toList(),
      ),
    );
  }
}
