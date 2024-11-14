import 'package:get/get.dart';

import '../controller/management_controller.dart';

class ManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ManagementController.new);
  }
}
