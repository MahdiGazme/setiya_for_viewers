import 'package:get/get.dart';

import '../controller/children_event_history_list_controller.dart';

class ChildrenEventHistoryListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ChildrenEventHistoryListController.new);
  }
}
