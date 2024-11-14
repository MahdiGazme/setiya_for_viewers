import 'package:get/get.dart';

import '../controllers/membership_request_edit_controller.dart';

class MembershipRequestEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(MembershipRequestEditController.new);
  }
}