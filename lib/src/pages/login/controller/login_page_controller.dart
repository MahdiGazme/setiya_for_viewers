import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../setia_module.dart';
import '../../../infrastructures/commons/storage_keys.dart';
import '../../../infrastructures/utils/token/token_info.dart';
import '../../shared/models/shared_user_login_dto.dart';
import '../../shared/repository/shared_login_repository.dart';

class LoginPageController extends GetxController {
  final _storage = GetStorage();

  final username = TextEditingController();
  final password = TextEditingController();

  final RxBool hasRememberMe = false.obs,
      isPasswordHide = true.obs,
      isLoggingIn = false.obs;

  final formKey = GlobalKey<FormState>();

  final _repository = SharedLoginRepository();

  Future<void> onLoginButtonTap() async {
    if (formKey.currentState!.validate()) {
      final userLoginInformation = SharedUserLoginDto(
        username: username.text,
        password: password.text,
      );
      await _login(userLoginInformation);
    }
  }

  Future<void> _login(final SharedUserLoginDto userLoginInformation) async {
    isLoggingIn.value = true;
    final resultOrException = await _repository.logIn(userLoginInformation);

    resultOrException.fold(
      (final exception) => isLoggingIn.value = false,
      (final result) async {
        if (hasRememberMe.value) {
          await _storeLoginInformation();
        }
        await TokenInfo.initialize(result);
        await _storeUserId();
        isLoggingIn.value = false;
        await Get.offAllNamed(SetiaModuleRouteNames.mainMenu);
      },
    );
  }

  Future<void> _storeUserId() async {
    await _storage.write(StorageKeys.userId, TokenInfo.id);
  }

  Future<void> _storeLoginInformation() async {
    await _storage.write(StorageKeys.loginProperties, {
      StorageKeys.username: username.text,
      StorageKeys.password: password.text,
    });
  }
}
