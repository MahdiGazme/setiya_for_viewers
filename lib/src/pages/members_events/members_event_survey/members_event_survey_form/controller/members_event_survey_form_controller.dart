import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../shared/models/enums/page_state_enum.dart';
import '../../../../shared/view/widgets/setiya_snackbar.dart';
import '../models/dto/members_event_survey_form_dto.dart';
import '../models/members_event_survey_form_view_model.dart';
import '../repository/members_event_survey_form_repository.dart';

class MembersEventSurveyFormController extends GetxController {
  final _repository = MembersEventSurveyFormRepository();

  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;

  final RxBool isLoading = false.obs;

  final comment = TextEditingController();

  double? rate;

  late MembersEventSurveyFormViewModel eventDetails;

  late String eventId;

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

  Future<void> onSubmitCommentTap() async {
    if (rate != null) {
      final dto = createDto();
      await _postComment(dto);
    } else {
      SetiyaSnackbar().showSnackbar(
        'هشدار',
        'لطفا اول امتیاز خود را وارد کنید',
        status: SetiyaSnackbarStatus.warning,
      );
    }
  }

  MembersEventSurveyFormDto createDto() => MembersEventSurveyFormDto(
        rate: rate!,
        comment: comment.text,
      );

  Future<void> _postComment(final MembersEventSurveyFormDto dto) async {
    isLoading.value = true;

    final resultOrException = await _repository.postRateAndComment(
      dto,
      eventId,
    );

    resultOrException.fold(
      (final exception) => isLoading.value = false,
      (final result) {
        SetiyaSnackbar().showSnackbar(
          'موفق',
          'امتیاز شما با موفقیت ثبت شد',
          status: SetiyaSnackbarStatus.success,
        );
        Get.back(
          result: true,
          closeOverlays: true,
        );
      },
    );
  }
}
