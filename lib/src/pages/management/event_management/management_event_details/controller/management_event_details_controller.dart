import 'package:get/get.dart';

import '../../../../../../setia_module.dart';
import '../../../../shared/models/enums/page_state_enum.dart';
import '../../../../shared/view/dialogs/delete_dialog.dart';
import '../models/management_event_details.dart';
import '../repository/management_event_details_repository.dart';

class ManagementEventDetailsController extends GetxController {
  late String eventId;
  final _repository = ManagementEventDetailsRepository();
  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;
  late ManagementEventDetailsViewModel eventDetails;
  final RxBool isDeleting = false.obs;

  @override
  void onInit() async {
    eventId = Get.parameters['eventId'] as String;
    await getEventDetails();
    super.onInit();
  }

  Future<void> getEventDetails() async {
    state.value = PageStateEnum.loading;
    final resultOrException = await _repository.getEventDetails(eventId);

    resultOrException.fold(
      (final exception) => state.value = PageStateEnum.retry,
      (final result) {
        eventDetails = result;
        state.value = PageStateEnum.success;
      },
    );
  }

  Future<void> deleteEvent() async {
    isDeleting.value = true;
    final resultOrException = await _repository.deleteEvent(eventId);
    resultOrException.fold(
      (final exception) => isDeleting.value = false,
      (final result) => Get.back(
        result: true,
        closeOverlays: true,
      ),
    );
  }

  void onEditEventTap() async {
    final result = await Get.toNamed(
      SetiaModuleRouteNames.editEvent,
      parameters: {
        'eventId': eventId,
      },
    );

    if (result != null && (result as bool)) {
      await getEventDetails();
    }
  }

  void onEventMembersSurveyListButtonTap() =>
      Get.toNamed(SetiaModuleRouteNames.managementEventMembersSurveyList,
          parameters: {
            'eventId': eventId,
          });

  Future<void> onEventMembersButtonTap() async {
    if (eventDetails.isExecuted) {
      _toEventAttendanceList();
    } else {
      await _toEventParticipantsList();
    }
  }

  void _toEventAttendanceList() {
    Get.toNamed(
      SetiaModuleRouteNames.eventParticipantsAttendance,
      parameters: {'eventId': eventId},
    );
  }

  Future<void> _toEventParticipantsList() async {
    await Get.toNamed(SetiaModuleRouteNames.manageEventParticipants,
        parameters: {
          'eventId': eventId,
        });
    await getEventDetails();
  }

  void onDeleteEventTap() async {
    await Get.dialog(
      DeleteDialog(
        onDeleteButtonTap: deleteEvent,
        bodyMessage: 'آیا از حذف این رویداد اطمینان دارید؟',
        isLoading: isDeleting,
      ),
    );
  }
}
