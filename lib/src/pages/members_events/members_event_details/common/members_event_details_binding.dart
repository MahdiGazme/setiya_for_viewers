import 'package:get/get.dart';

import '../controller/members_event_details_controller.dart';

class MembersEventDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(MembersEventDetailsController.new);
  }
}
