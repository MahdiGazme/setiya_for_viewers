import 'package:get/get.dart';

import '../controller/members_event_survey_list_controller.dart';

class MembersEventSurveyListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      MembersEventSurveyListController.new,
    );
  }
}
