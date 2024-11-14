import 'package:get/get.dart';

import '../controller/management_event_members_survey_list_controller.dart';

class MembersEventMembersSurveyListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      ManagementEventMembersSurveyListController.new,
    );
  }
}
