import 'package:milky_http_client/milky_http_client.dart';

import '../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/event_member_comment_view_model.dart';

class EventMemberCommentDetailsRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, EventMemberCommentViewModel>> getMemberComment(
      final String commentId) async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getEventMemberCommentDetailsForManagement(
        commentId,
      ),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        EventMemberCommentViewModel.fromJson(
          result.data,
        ),
      ),
    );
  }
}
