import 'package:get/get.dart';

import '../controller/members_event_history_list_controller.dart';

class MemberEventHistoryListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(MembersEventsHistoryListController.new);
  }
}
