import 'package:get/get.dart';

import '../controller/authorize_request_list_controller.dart';

class AuthorizeRequestListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AuthorizeRequestListController.new);
  }
}
