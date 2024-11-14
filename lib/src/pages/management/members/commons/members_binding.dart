import 'package:get/get.dart';

import '../controller/members_controller.dart';

class MembersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(MembersController.new);
  }
}
