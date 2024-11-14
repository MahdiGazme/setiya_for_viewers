import 'package:get/get.dart';

import '../../../../../shared/models/enums/page_state_enum.dart';
import '../../../../../shared/view/widgets/setiya_snackbar.dart';
import '../models/event_attendance_member_view_model.dart';
import '../repository/submit_event_entrance_dialog_repository.dart';

class SubmitEventAttendanceDialogController extends GetxController {
  final _repository = SubmitEventAttendanceDialogRepository();

  final RxBool isLoading = false.obs;

  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;

  late EventAttendanceMemberViewModel memberInformation;

  final String memberCodeOrMemberId;
  final String eventId;
  final bool isGetById;

  SubmitEventAttendanceDialogController({
    required this.memberCodeOrMemberId,
    required this.eventId,
    required this.isGetById,
  });

  @override
  void onInit() async {
    await getMemberInformation();
    super.onInit();
  }

  Future<void> onSubmitButtonTap() async {
    isLoading.value = true;
    final resultOrException = await _repository.submitEventAttendance(
      eventId,
      memberInformation.id,
    );

    resultOrException.fold(
      (final exception) => isLoading.value = false,
      (final result) {
        isLoading.value = false;
        Get.back();
        SetiyaSnackbar().showSnackbar(
          'موفق',
          'ثبت ورود با موفقیت انجام شد',
          status: SetiyaSnackbarStatus.success,
        );
      },
    );
  }

  Future<void> getMemberInformation() async {
    if (isGetById) {
      await _getMemberInformationById(
        memberCodeOrMemberId,
      );
    } else {
      await _getMemberInformationByMembership(
        memberCodeOrMemberId,
      );
    }
  }

  Future<void> _getMemberInformationById(final String id) async {
    state.value = PageStateEnum.loading;
    final resultOrException = await _repository.getMemberInformationById(
      id,
      eventId,
    );

    resultOrException.fold(
          (final exception) => state.value = PageStateEnum.retry,
      (final result) {
        memberInformation = result;
        state.value = PageStateEnum.success;
      },
    );
  }

  Future<void> _getMemberInformationByMembership(
      final String membership) async {
    state.value = PageStateEnum.loading;
    final resultOrException =
        await _repository.getMemberInformationByMembershipCode(
      membership,
      eventId,
    );

    resultOrException.fold(
      (final exception) => state.value = PageStateEnum.retry,
      (final result) {
        memberInformation = result;
        state.value = PageStateEnum.success;
      },
    );
  }
}
