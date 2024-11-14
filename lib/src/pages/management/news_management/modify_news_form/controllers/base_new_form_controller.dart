import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:milky_http_client/milky_http_client.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../shared/models/enums/page_state_enum.dart';
import '../../../../shared/repository/shared_repository.dart';
import '../../../../shared/view/widgets/setiya_snackbar.dart';

abstract class BaseNewsFormController extends GetxController {
  final _uploadImageRepository = SharedRepository();

  final state = PageStateEnum.success.obs;

  final Rxn<String> mainPictureId = Rxn(null);

  final RxList<String> pictureIds = <String>[].obs;

  Rxn<Jalali> expireDate = Rxn(null);

  final GlobalKey<FormState> formKey = GlobalKey();

  final isUploading = false.obs,
      isPicturesUploading = false.obs,
      hasExpireDate = false.obs;

  final title = TextEditingController(), content = TextEditingController();

  void onButtonTap();

  Future<void> onAddPictureTap(final List<XFile> selectedImages) async {
    if (selectedImages.length <= 5 &&
        (selectedImages.length + pictureIds.length) <= 5) {
      isPicturesUploading.value = true;
      for (final element in selectedImages) {
        final formData = await _createDto(element);

        final resultOrException = await _uploadImageRepository.uploadImage(
          formData,
        );

        resultOrException.fold(
          (final exception) => null,
          (final result) {
            mainPictureId.value ??= result;
            pictureIds.add(result);
          },
        );
      }
      isPicturesUploading.value = false;
    } else {
      SetiyaSnackbar().showSnackbar(
        'هشدار',
        'مجموع عکس های انتخاب شده بیشتر از حد مجاز است',
        status: SetiyaSnackbarStatus.warning,
      );
    }
  }

  String? expireDateValidator(final String? value) {
    if (hasExpireDate.value && expireDate.value == null) {
      return 'لطفا تاریخ انقضا را وارد کنید';
    }

    return null;
  }

  bool validateForm() {
    if (formKey.currentState!.validate()) {
      if (pictureIds.isNotEmpty) {
        return true;
      } else {
        SetiyaSnackbar().showSnackbar(
          'هشدار',
          'لطفا عکس ها را آپلود کنید',
          status: SetiyaSnackbarStatus.warning,
        );
        return false;
      }
    }
    return false;
  }

  Future<FormData> _createDto(final XFile element) async {
    final bytes = await element.readAsBytes();
    final MultipartFile multipartFile =
        MultipartFile.fromBytes(bytes, filename: element.name);
    final formData = FormData.fromMap({
      'file': multipartFile,
    });
    return formData;
  }

  void onDeletePictureTap(final String id) {
    pictureIds.removeWhere((final element) => element == id);
    if (pictureIds.isEmpty) {
      mainPictureId.value = null;
    } else if (mainPictureId.value == id) {
      mainPictureId.value = pictureIds.first;
    }
  }

  void onMakeMainPictureTap(final String id) {
    if (mainPictureId.value != id) {
      mainPictureId.value = id;
    }
  }

  Future<void> getOldNews();

  Future<void> releaseNews();
}
