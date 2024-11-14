import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../../../setia_module.dart';
import '../../submit_event_entrance_dialog/controller/submit_event_entrance_dialog_controller.dart';
import '../../submit_event_entrance_dialog/view/submit_event_entrance_dialog.dart';
import '../views/dialogs/attendance_by_membership_code_dialog.dart';

class SubmitEventAttendanceController extends GetxController {
  final formKey = GlobalKey<FormState>();

  late String eventId;

  @override
  void onInit() {
    eventId = Get.parameters['eventId'] as String;
    super.onInit();
  }

  void onScanQrcodeButtonTap() async {
    final result = await Get.toNamed(
      SetiaModuleRouteNames.qrcodeScanner,
    );
    if (result != null) {
      await Get.dialog(
        SubmitEventAttendanceDialog(
          () => SubmitEventAttendanceDialogController(
            memberCodeOrMemberId: result as String,
            eventId: eventId,
            isGetById: true,
          ),
        ),
      );
    }
  }

  void onMembershipCodeButtonTap() async {
    await Get.dialog(
      AttendanceByMembershipCodeDialog(
        formKey: formKey,
        onTap: onSearchMembershipCodeTap,
      ),
    );
  }

  void onSearchMembershipCodeTap(final String membershipCode) async {
    if (formKey.currentState!.validate()) {
      Get.back();
      await Get.dialog(
        SubmitEventAttendanceDialog(
          () => SubmitEventAttendanceDialogController(
            memberCodeOrMemberId: membershipCode,
            eventId: eventId,
            isGetById: false,
          ),
        ),
      );
    }
  }
}
