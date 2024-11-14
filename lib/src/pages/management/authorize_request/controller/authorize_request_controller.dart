import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../setia_module.dart';
import '../../../shared/models/enums/page_state_enum.dart';
import '../models/authorize_request_view_model.dart';
import '../models/dto/authorize_request_answer_dto.dart';
import '../repository/authorize_request_repository.dart';
import '../view/widgets/answer_request_dialog.dart';

class AuthorizeRequestController extends GetxController {
  final _repository = AuthorizeRequestRepository();
  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;
  final Rx<bool> isLoading = false.obs, hasAccepted = false.obs;

  late AuthorizeRequestViewModel requestDetails;
  late String requestId;

  @override
  void onInit() async {
    requestId = Get.parameters['requestId']!;
    await getRequest();
    super.onInit();
  }

  Future<void> getRequest() async {
    state.value = PageStateEnum.loading;
    final resultOrException = await _repository.getRequest(requestId);

    resultOrException.fold(
      (final exception) => state.value = PageStateEnum.retry,
      (final result) {
        requestDetails = result;
        state.value = PageStateEnum.success;
      },
    );
  }

  void onChildItemTap(
    final String memberId,
  ) async {
    final result = await Get.toNamed(
      SetiaModuleRouteNames.managementUserProfile,
      parameters: {
        'userId': memberId,
      },
    );

    if(result != null && result as bool) {
      await getRequest();
    }
  }

  void onAnswerDialogSubmitButtonTap() async {
    final dto = AuthorizeRequestAnswerDto(hasAccepted: hasAccepted.value);
    await postAnswer(requestId, dto);
  }

  void onAnswerButtonTap() async {
    final result = await Get.dialog(const AnswerDialogRequest());
    if (result != null && (result as bool)) {
      Get.back(result: true);
    }
  }

  Future<void> postAnswer(
    final String requestId,
    final AuthorizeRequestAnswerDto dto,
  ) async {
    isLoading.value = true;
    final resultOrException = await _repository.postAnswer(
      requestId: requestId,
      dto: dto,
    );

    resultOrException.fold(
      (final exception) => isLoading.value = false,
      (final result) => Get.back(
        result: true,
        closeOverlays: true,
      ),
    );
  }

  void onPhoneButtonTap() async {
    final url = Uri.parse('tel://+98${requestDetails.mobileNumber}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void onSMSButtonTap() async {
    final url = Uri.parse('sms://+98${requestDetails.mobileNumber}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}
