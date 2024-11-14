import 'package:get/get.dart';

import '../controllers/membership_request_add_controller.dart';

class MembershipRequestAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(MembershipRequestAddController.new);
  }
}