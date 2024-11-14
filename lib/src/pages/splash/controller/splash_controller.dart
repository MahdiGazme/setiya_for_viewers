import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../setia_module.dart';
import '../../../infrastructures/commons/storage_keys.dart';
import '../../../infrastructures/utils/token/token_info.dart';
import '../../shared/models/shared_user_login_dto.dart';
import '../../shared/repository/shared_login_repository.dart';
import '../../shared/view/dialogs/not_connected_dialog.dart';

class SplashController extends GetxController {
  final GetStorage _storage = GetStorage();
  final SharedLoginRepository _repository = SharedLoginRepository();
  final RxBool isNetworkConnected = true.obs;

  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 1));
    await checkConnection();
    super.onInit();
  }

  Future<void> _readStorage() async {
    final loginInformation = _storage.read(StorageKeys.loginProperties);

    if (loginInformation != null) {
      final dto = _createDto(loginInformation);
      await _login(dto);
    } else {
      await Get.offAndToNamed(SetiaModuleRouteNames.mainMenu);
    }
  }

  Future<void> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isNetworkConnected.value = true;
        await _readStorage();
      }
    } on SocketException catch (_) {
      isNetworkConnected.value = false;
      await Get.dialog(
        const NotConnectedDialog(),
      );
      print('--------->INTERNET CONNECTION ERROR <--------');
    } catch (_) {
      print(_);
    }
  }

  Future<void> _login(
    final SharedUserLoginDto userLoginInformation,
  ) async {
    final resultOrException = await _repository.logIn(userLoginInformation);

    await resultOrException.fold(
      (final left) => Get.offAndToNamed(SetiaModuleRouteNames.mainMenu),
      (final right) async {
        await TokenInfo.initialize(right);
        await Get.offAndToNamed(SetiaModuleRouteNames.mainMenu);
      },
    );
  }

  SharedUserLoginDto _createDto(
    final Map<String, dynamic> userStoredLoginInformation,
  ) =>
      SharedUserLoginDto(
        username: userStoredLoginInformation[StorageKeys.username],
        password: userStoredLoginInformation[StorageKeys.password],
      );
}
