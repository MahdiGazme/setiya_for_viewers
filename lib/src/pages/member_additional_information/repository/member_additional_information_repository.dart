import 'package:milky_http_client/milky_http_client.dart';

import '../../../infrastructures/commons/repository_urls.dart';
import '../../../infrastructures/utils/http_client/http_client_utils.dart';
import '../model/dto/member_additional_information_dto.dart';
import '../model/member_additional_information_view_model.dart';

class MemberAdditionalInformationRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, MemberAdditionalInformationViewModel?>>
      getAdditionalInformation() async {
    final resultOrException = await _httpClient.get(
      RepositoryUrls.getLastMemberAdditionalInformation,
    );

    return resultOrException.fold(
      Left.new,
      (final result) {
        if (result.statusCode == 204) {
          return const Right(null);
        }

        return Right(
          MemberAdditionalInformationViewModel.fromJson(
            result.data,
          ),
        );
      },
    );
  }

  Future<Either<String, String>> updateAdditionalInformation(
      final MemberAdditionalInformationDto dto) async {
    final resultOrException = await _httpClient.patch(
      RepositoryUrls.updateMemberAdditionalInformation,
      data: dto.toJson(),
    );

    return resultOrException.fold(
      Left.new,
      (final result) => Right(result.data),
    );
  }
}

