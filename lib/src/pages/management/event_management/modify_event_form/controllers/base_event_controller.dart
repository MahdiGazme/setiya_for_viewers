import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'package:milky_http_client/milky_http_client.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../shared/models/enums/events_contact_type_enum.dart';
import '../../../../shared/models/enums/page_state_enum.dart';
import '../../../../shared/repository/shared_repository.dart';
import '../../../../shared/view/widgets/setiya_snackbar.dart';

abstract class BaseEventController extends GetxController {
  final _uploadImageRepository = SharedRepository();

  final formKey = GlobalKey<FormState>();

  final Rx<PageStateEnum> state = PageStateEnum.success.obs;

  Rxn<JalaliRange?> dateRange = Rxn(null);

  TimeOfDay? startTime, endTime;

  RxList<String> imageIds = <String>[].obs;

  Rxn<String> mainImageId = Rxn(null);

  Rx<EventContactTypEnum> contactType = EventContactTypEnum.justMembers.obs;

  RxBool needAcceptMember = false.obs,
      isLoading = false.obs,
      isImageUploading = false.obs;

  final TextEditingController title = TextEditingController(),
      description = TextEditingController(),
      address = TextEditingController(),
      maxCapacity = TextEditingController(),
      minimumRate = TextEditingController(),
      giftRate = TextEditingController(),
      price = TextEditingController();

  void onReleaseButtonTap();

  void onRetryButtonTap();

  Future<void> onPhotoPickerButtonTap(final List<XFile> selectedImages) async {
    if (selectedImages.length <= 5 &&
        (selectedImages.length + imageIds.length) <= 1) {
      isImageUploading.value = true;
      for (final element in selectedImages) {
        final formData = await _createDto(element);

        final resultOrException = await _uploadImageRepository.uploadImage(
          formData,
        );

        resultOrException.fold(
          (final exception) => null,
          (final result) {
            mainImageId.value ??= result;
            imageIds.add(result);
          },
        );
      }
      isImageUploading.value = false;
    } else {
      SetiyaSnackbar().showSnackbar(
        'هشدار',
        'مجموع عکس های انتخاب شده بیشتر از حد مجاز است',
        status: SetiyaSnackbarStatus.warning,
      );
    }
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

  void onDeleteImageTap(final String id) {
    imageIds.removeWhere((final element) => element == id);
    if (imageIds.isEmpty) {
      mainImageId.value = null;
    } else if (mainImageId.value == id) {
      mainImageId.value = imageIds.first;
    }
  }

  void onMakeMainImageTap(final String id) {
    if (mainImageId.value != id) {
      mainImageId.value = id;
    }
  }

  void onContactTypeChanged(final EventContactTypEnum value) {
    if (value != contactType.value) {
      contactType.value = value;
    }
  }

  String? startAndEndTimeValidator() {
    if (dateRange.value != null) {
      if (startTime != null) {
        if (dateRange.value!.start.isBefore(dateRange.value!.end)) {
          return null;
        } else if (endTime != null) {
          if (timeOfDayToDouble(startTime!) < timeOfDayToDouble(endTime!)) {
            return null;
          } else {
            return 'ساعت شروع نمیتواند قبل از ساعت پایان باشد';
          }
        } else {
          return null;
        }
      } else if (endTime != null) {
        return 'ساعت شروع نمی تواند خالی باشد';
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  double timeOfDayToDouble(final TimeOfDay time) =>
      time.hour + time.minute / 60.0;
}
