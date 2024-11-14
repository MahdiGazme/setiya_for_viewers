import 'package:get/get.dart' hide FormData;
import 'package:milky_http_client/milky_http_client.dart';

import '../../../../../../infrastructures/commons/repository_urls.dart';
import '../repositories/setia_avatar_selector_repository.dart';

class SetiaAvatarSelectorController {
  final _repository = SetiaAvatarSelectorRepository();

  final String? avatarId;

  final RxBool showLoading = false.obs;

  SetiaAvatarSelectorController({
    this.avatarId,
  });

  String? get src =>
      avatarId != null ? RepositoryUrls.downloadDocumentUrl(avatarId!) : null;

  Future<String?> uploadAvatar(final FormData image) async {
    showLoading.value = true;
    final resultOrException = await _repository.uploadAvatar(image);

    return resultOrException.fold(
      (final exception) {
        showLoading.value = false;
        return null;
      },
      (final result) {
        showLoading.value = false;
        return result;
      },
    );
  }
}
