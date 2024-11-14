import 'package:get/get.dart';

import '../../../../shared/models/enums/page_state_enum.dart';
import '../../../../shared/models/members_event_history_details_view_model.dart';
import '../repository/members_even_history_details_repository.dart';
import '../views/dialogs/cancel_evwent_dialog.dart';

class MembersEventHistoryDetailsController extends GetxController {
  final _repository = MemberEventHistoryDetailsRepository();
  late String eventId;
  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;
  late MembersEventHistoryDetailsViewModel eventDetails;
  final isLoading = false.obs;

  @override
  void onInit() async {
    eventId = Get.parameters['eventId']!;
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

  void onCancelRegistrationButtonTap() {
    Get.dialog(const CancelEventRegistrationDialog());
  }

  Future<void> cancelEvent() async {
    isLoading.value = true;
    final resultOrException = await _repository.cancelEvent(eventId);

    resultOrException.fold(
      (final exception) => isLoading.value = false,
      (final result) => Get.back(
        result: true,
        closeOverlays: true,
      ),
    );
  }
}
