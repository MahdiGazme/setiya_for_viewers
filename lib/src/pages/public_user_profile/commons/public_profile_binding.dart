import 'package:get/get.dart';

import '../controller/public_profile_controller.dart';

class PublicProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(PublicProfileController.new);
  }
}