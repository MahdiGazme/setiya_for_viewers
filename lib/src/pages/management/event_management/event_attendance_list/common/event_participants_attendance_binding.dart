import 'package:get/get.dart';

import '../controller/event_participants_attendance_controller.dart';

class EventParticipantsAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(EventParticipantAttendanceController.new);
  }
}
