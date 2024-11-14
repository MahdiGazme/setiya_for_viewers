import 'package:get/get.dart';

import '../controller/manage_event_participants_controller.dart';

class ManageEventParticipantsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ManageEventParticipantsController.new);
  }
}
