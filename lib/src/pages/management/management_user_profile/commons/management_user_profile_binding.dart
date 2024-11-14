import 'package:get/get.dart';

import '../controller/management_user_profile_controller.dart';

class ManagementUserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      ManagementUserProfileController.new,
      tag: Get.parameters['userId'],
    );
  }
}
