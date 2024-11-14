import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructures/commons/storage_keys.dart';
import '../../shared/view/widgets/setiya_snackbar.dart';
import '../models/change_password_dto.dart';
import '../repository/change_password_repository.dart';

class ChangePasswordController extends GetxController {
  final _repository = ChangePasswordRepository();

  final oldPassword = TextEditingController(),
      newPassword = TextEditingController(),
      repeatNewPassword = TextEditingController();

  final RxBool isOldPasswordHide = true.obs,
      isNewPasswordHide = true.obs,
      isRepeatNewPasswordHide = true.obs,
      isLoading = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey();

  Future<void> onChangePasswordTap() async {
    if (formKey.currentState!.validate()) {
      final dto = ChangePasswordDto(
        oldPassword: oldPassword.text,
        newPassword: newPassword.text,
      );
      await _changePassword(dto);
    }
  }

  Future<void> _changePassword(final ChangePasswordDto dto) async {
    isLoading.value = true;
    final resultOrException = await _repository.changePassword(dto);

    resultOrException.fold(
      (final exception) => isLoading.value = false,
      (final result) async {
        await _updateStoredPasswordIfExist();
        Get.back();
        SetiyaSnackbar().showSnackbar(
          LocaleKeys.setia_module_shared_commons_success.tr,
          LocaleKeys
              .setia_module_pages_change_password_change_password_was_success
              .tr,
          status: SetiyaSnackbarStatus.success,
        );
      },
    );
  }

  Future<void> _updateStoredPasswordIfExist() async {
    final storage = GetStorage();
    final storedLoginProperties = storage.read(
      StorageKeys.loginProperties,
    );

    if (storedLoginProperties != null) {
      await storage.write(StorageKeys.loginProperties, {
        StorageKeys.username: (storedLoginProperties
            as Map<String, String>)[StorageKeys.username],
        StorageKeys.password: newPassword.text,
      });
    }
  }
}
