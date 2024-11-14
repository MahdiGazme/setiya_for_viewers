import 'package:get/get.dart';

import '../controller/children_list_controller.dart';


class ChildrenListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ChildrenListController.new);
  }
}
