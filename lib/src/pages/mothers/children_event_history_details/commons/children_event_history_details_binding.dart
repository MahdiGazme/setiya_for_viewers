import 'package:get/get.dart';

import '../controller/children_event_history_details_controller.dart';


class ChildrenEventHistoryDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ChildrenEventHistoryDetailsController.new);
  }
}
