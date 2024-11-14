import 'package:get/get.dart';

import '../controller/active_events_controller.dart';

class ActiveEventsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ActiveEventsController.new);
  }
}
