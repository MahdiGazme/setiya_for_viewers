import 'package:get/get.dart';

import '../../../shared/models/enums/page_state_enum.dart';
import '../../../shared/view/widgets/setiya_snackbar.dart';
import '../model/dto/members_event_submit_request_dto.dart';
import '../model/members_event_details_view_model.dart';
import '../repository/members_event_details_repository.dart';
import '../view/widgets/dialogs/member_event_submit_await_dialog.dart';
import '../view/widgets/dialogs/member_event_submit_dialog.dart';

class MembersEventDetailsController extends GetxController {
  final _repository = MembersEventDetailsRepository();
  late String eventId;
  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;
  late MembersEventDetailsViewModel eventDetails;
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

  Future<void> onSubmitButtonTap() async {
    final result = await Get.dialog(
      const MemberEventSubmitDialog(),
    );
    if (result != null && result as bool) {
      if (eventDetails.needToAcceptByManager) {
        await Get.dialog(
          const MemberEventSubmitAwaitDialog(),
        );
        Get.back();
      } else {
        Get.back(
          result: true,
        );
        SetiyaSnackbar().showSnackbar(
          'پیام',
          'ثبت نام شما با موفقیت انجام شد',
          status: SetiyaSnackbarStatus.success,
        );
      }
    }
  }

  Future<void> sentSubmitRequest() async {
    isLoading.value = true;
    final dto = _createDto();
    final resultOrException = await _repository.submitRequest(
      dto,
      eventId,
    );

    resultOrException.fold(
      (final exception) => isLoading.value = false,
      (final result) => Get.back(
        result: true,
      ),
    );
  }

  MemberEventSubmitRequestDto _createDto() => MemberEventSubmitRequestDto(
        eventId: int.parse(eventId),
      );
}
