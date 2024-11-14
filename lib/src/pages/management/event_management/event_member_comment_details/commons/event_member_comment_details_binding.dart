import 'package:get/get.dart';

import '../controller/event_member_comment_details_controller.dart';

class EventMemberCommentDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      EventMemberCommentDetailsController.new,
    );
  }
}
