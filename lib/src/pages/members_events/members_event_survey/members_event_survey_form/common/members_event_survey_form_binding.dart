import 'package:get/get.dart';

import '../controller/members_event_survey_form_controller.dart';

class MembersEventSurveyFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      MembersEventSurveyFormController.new,
    );
  }
}
