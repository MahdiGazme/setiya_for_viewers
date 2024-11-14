import 'package:get/get.dart';

import '../../../shared/models/enums/page_state_enum.dart';
import '../../../shared/models/members_event_history_details_view_model.dart';
import '../repository/children_even_history_details_repository.dart';

class ChildrenEventHistoryDetailsController extends GetxController {
  final _repository = ChildrenEventHistoryDetailsRepository();
  late String eventId;
  late String childId;
  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;
  late MembersEventHistoryDetailsViewModel eventDetails;

  @override
  void onInit() async {
    eventId = Get.parameters['eventId']!;
    childId = Get.parameters['childId']!;
    await getEventDetails();
    super.onInit();
  }

  Future<void> getEventDetails() async {
    state.value = PageStateEnum.loading;
    final resultOrException = await _repository.getEventDetails(
      eventId,
      childId,
    );

    resultOrException.fold(
      (final exception) => state.value = PageStateEnum.retry,
      (final result) {
        eventDetails = result;
        state.value = PageStateEnum.success;
      },
    );
  }

}
