import 'package:get/get.dart';
import '../../../../../infrastructures/extensions/iterable_extensions.dart';
import '../../../../shared/models/enums/page_state_enum.dart';
import '../models/dto/edit_news_dto.dart';
import '../models/management_news_view_model.dart';
import '../repositories/edit_new_form_repository.dart';
import 'base_new_form_controller.dart';

class EditNewsFormController extends BaseNewsFormController {
  final _repository = EditNewsFormRepository();

  final String newsId = Get.parameters['newsId']!;

  final List<String> oldPicturesIds = [];

  @override
  void onInit() async {
    await getOldNews();
    super.onInit();
  }

  @override
  Future<void> getOldNews() async {
    state.value = PageStateEnum.loading;

    final resultOrException = await _repository.getOldNews(newsId);

    resultOrException.fold(
      (final exception) => state.value = PageStateEnum.retry,
      (final result) {
        _initialValues(result);
        state.value = PageStateEnum.success;
      },
    );
  }

  void _initialValues(final ManagementNewsViewModel model) {
    expireDate.value = model.expireDate;
    pictureIds.addAll(model.imageIds);
    title.text = model.title;
    mainPictureId.value = model.mainImageId;
    content.text = model.content;
    hasExpireDate.value = model.expireDate != null;
    oldPicturesIds.addAll(model.imageIds);
  }

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
    final resultOrException = await _repository.editNews(newsId, dto);

    resultOrException.fold((final exception) => isUploading.value = false,
        (final result) {
      isUploading.value = false;
      Get.back(result: true);
    });
  }

  EditNewsDto _createDto() => EditNewsDto(
        newImageIds: pictureIds
            .exceptWhere(
              oldPicturesIds,
              (final firstElement, final secondElement) =>
                  firstElement == secondElement,
            )
            .toList(),
        deletedImageIds: oldPicturesIds
            .exceptWhere(
              pictureIds,
              (final firstElement, final secondElement) =>
                  firstElement == secondElement,
            )
            .toList(),
        mainImageId: mainPictureId.value!,
        title: title.text,
        content: content.text,
        expireDate: hasExpireDate.value ? expireDate.value! : null,
      );
}
