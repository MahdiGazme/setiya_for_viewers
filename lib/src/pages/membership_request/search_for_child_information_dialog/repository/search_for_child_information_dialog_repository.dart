import 'package:milky_http_client/milky_http_client.dart';

import '../../../../infrastructures/commons/repository_urls.dart';
import '../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/child_information_dialog_view_model.dart';

class SearchForChildInformationDialogRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, ChildInformationDialogViewModel>>
      getChildInformation(
    final String nationalCode,
  ) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.checkChildIsAvailable(
        nationalCode,
      ),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        ChildInformationDialogViewModel.fromJson(
          result.data,
        ),
      ),
    );
  }
}
