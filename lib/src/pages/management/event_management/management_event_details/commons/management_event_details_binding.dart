import 'package:get/get.dart';

import '../controller/management_event_details_controller.dart';

class ManagementEventDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      ManagementEventDetailsController.new,
    );
  }
}
