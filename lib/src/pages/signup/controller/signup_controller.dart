import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../setia_module.dart';
import '../../../infrastructures/commons/storage_keys.dart';
import '../../../infrastructures/utils/token/token_info.dart';
import '../../shared/models/shared_user_login_dto.dart';
import '../../shared/repository/shared_login_repository.dart';
import '../../shared/view/widgets/setiya_snackbar.dart';
import '../models/dto/signup_dto.dart';
import '../repository/signup_repository.dart';

class SignupController extends GetxController {
  final _storage = GetStorage();
  final _repository = SignupRepository();
  final _sharedRepository = SharedLoginRepository();

  final username = TextEditingController();
  final password = TextEditingController();
  final repeatPassword = TextEditingController();

  final RxBool hasRememberMe = false.obs,
      isPasswordHide = true.obs,
      isRepeatPasswordHide = true.obs,
      isAgreedToRules = false.obs,
      isSigning = false.obs;

  final formKey = GlobalKey<FormState>();

  Future<void> onSignupButtonTap() async {
    if (formKey.currentState!.validate()) {
      if (!isAgreedToRules.value) {
        SetiyaSnackbar().showSnackbar(
          'هشدار',
          'لطفا ابتدا قوانین را مطالعه و سپس قبول کنید',
          status: SetiyaSnackbarStatus.warning,
        );
      } else {
        final signupDto = _createSignupDto();
        await _signup(signupDto);
      }
    }
  }

  void onRulesTap() {
    Get.toNamed(
      SetiaModuleRouteNames.rulesAndConditions,
    );
  }

  SignupDto _createSignupDto() => SignupDto(
        nationalCode: username.text,
        password: password.text,
      );

  Future<void> _signup(final SignupDto dto) async {
    isSigning.value = true;
    final resultOrException = await _repository.signup(dto);

    resultOrException.fold(
      (final exception) => isSigning.value = false,
      (final result) async {
        final loginDto = _createLoginDto();
        await _login(loginDto);
      },
    );
  }

  Future<void> _login(final SharedUserLoginDto loginDto) async {
    final resultOrException = await _sharedRepository.logIn(loginDto);

    resultOrException.fold(
      (final exception) => isSigning.value = false,
      (final result) async {
        if (hasRememberMe.value) {
          await _storeLoginInformation();
        }
        await TokenInfo.initialize(result);
        await Get.offAllNamed(SetiaModuleRouteNames.mainMenu);
      },
    );
  }

  Future<void> _storeLoginInformation() async {
    await _storage.write(StorageKeys.loginProperties, {
      StorageKeys.username: username.text,
      StorageKeys.password: password.text,
    });
  }

  SharedUserLoginDto _createLoginDto() => SharedUserLoginDto(
        username: username.text,
        password: password.text,
      );
}
