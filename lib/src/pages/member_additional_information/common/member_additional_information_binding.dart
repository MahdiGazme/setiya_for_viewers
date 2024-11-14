import 'package:get/get.dart';

import '../controller/member_additional_information_controller.dart';

class MemberAdditionalInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(MemberAdditionalInformationController.new);
  }
}
