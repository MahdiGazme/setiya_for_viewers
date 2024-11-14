
import 'package:milky_http_client/milky_http_client.dart';

import '../../../infrastructures/commons/repository_urls.dart';
import '../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../models/dto/change_avatar_dto.dart';
import '../models/public_profile_view_model.dart';

class PublicProfileRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, PublicProfileViewModel?>> getProfileData() async {
    final resultOrException =
        await _httpClient.get(RepositoryUrls.getPublicProfileData);

    return resultOrException.fold(
      Left.new,
      (final result) {
        if (result.statusCode == 204) {
          return const Right(null);
        }
        return Right(
          PublicProfileViewModel.fromJson(result.data),
        );
      },
    );
  }

  Future<Either<String, String>> changeAvatar(final ChangeAvatarDto dto) async {
    final resultOrException = await _httpClient.patch(
      RepositoryUrls.changeAvatar,
      data: dto.toJson(),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(
        result.data,
      ),
    );
  }

  Future<Either<String, String>> deleteAvatar(final ChangeAvatarDto dto) async {
    final resultOrException = await _httpClient.patch(
      RepositoryUrls.deleteAvatar,
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
