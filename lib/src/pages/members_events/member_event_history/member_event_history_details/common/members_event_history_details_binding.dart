import 'package:get/get.dart';

import '../controller/members_event_history_details_controller.dart';

class MembersEventHistoryDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(MembersEventHistoryDetailsController.new);
  }
}
