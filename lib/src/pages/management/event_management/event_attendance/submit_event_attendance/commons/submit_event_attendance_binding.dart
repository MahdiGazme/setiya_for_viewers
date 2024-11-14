import 'package:get/get.dart';

import '../controller/submit_event_attendance_controller.dart';

class SubmitEventAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SubmitEventAttendanceController.new);
  }
}
