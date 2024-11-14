import 'package:get/get.dart' hide MultipartFile, FormData;

import '../models/dto/add_news_dto.dart';
import '../repositories/add_new_form_repository.dart';
import 'base_new_form_controller.dart';

class AddNewsFormController extends BaseNewsFormController {
  final _repository = AddNewsFormRepository();

  @override
  void onButtonTap() async {
    final isValid = validateForm();
    if (isValid) {
      await releaseNews();
    }
  }

  @override
  Future<void> releaseNews() async {
    isUploading.value = true;
    final dto = _createDto();
    final resultOrException = await _repository.postNews(dto);

    resultOrException.fold((final exception) => isUploading.value = false,
        (final result) {
      isUploading.value = false;
      Get.back(result: true);
    });
  }

  AddNewsDto _createDto() => AddNewsDto(
        imageIds: pictureIds,
        mainImageId: mainPictureId.value!,
        title: title.text,
        content: content.text,
        expireDate: hasExpireDate.value ? expireDate.value! : null,
      );

  @override
  Future<void> getOldNews() {
    throw UnimplementedError();
  }
}
