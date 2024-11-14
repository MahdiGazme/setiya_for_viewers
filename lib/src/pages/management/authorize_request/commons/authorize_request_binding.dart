import 'package:get/get.dart';

import '../controller/authorize_request_controller.dart';

class AuthorizeRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AuthorizeRequestController.new);
  }
}
