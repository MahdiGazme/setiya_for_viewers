import 'package:get/get.dart';

import '../controller/management_events_list_controller.dart';

class ManagementEventsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      ManagementEventsListController.new,
    );
  }
}
