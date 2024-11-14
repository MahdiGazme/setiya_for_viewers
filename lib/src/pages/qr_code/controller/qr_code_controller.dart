import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../setia_module.dart';
import '../../../infrastructures/commons/storage_keys.dart';

class QrcodeController extends GetxController {
  final RxBool hasData = false.obs;
  late String qrcodeDate;

  @override
  void onInit() {
    _readUserDataFromStorage();
    super.onInit();
  }

  void _readUserDataFromStorage() {
    final storage = GetStorage();
    final data = storage.read(StorageKeys.userId);
    if (data != null) {
      qrcodeDate = data as String;
      hasData.value = true;
    }
  }

  void onLoginButtonTap() => Get.toNamed(
        SetiaModuleRouteNames.logIn,
      );
}
