import 'package:get/get.dart';

import '../controller/qr_code_controller.dart';

class QrcodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(QrcodeController.new);
  }
}
