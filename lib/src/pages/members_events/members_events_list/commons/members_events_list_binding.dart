import 'package:get/get.dart';

import '../controller/members_events_list_controller.dart';

class MembersEventsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(MembersEventsListController.new);
  }
}
