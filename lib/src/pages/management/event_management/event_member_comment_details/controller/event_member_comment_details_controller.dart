import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../setia_module.dart';
import '../../../../shared/models/enums/page_state_enum.dart';
import '../models/event_member_comment_view_model.dart';
import '../repository/event_member_comment_details_repository.dart';

class EventMemberCommentDetailsController extends GetxController {
  final _repository = EventMemberCommentDetailsRepository();

  final state = PageStateEnum.loading.obs;

  late String commentId;

  late EventMemberCommentViewModel memberComment;

  @override
  void onInit() async {
    commentId = Get.parameters['commentId'] as String;
    await getCommentDetails();
    super.onInit();
  }

  Future<void> getCommentDetails() async {
    state.value = PageStateEnum.loading;

    final resultOrException = await _repository.getMemberComment(commentId);

    resultOrException.fold(
      (final exception) => state.value = PageStateEnum.retry,
      (final result) {
        memberComment = result;
        state.value = PageStateEnum.success;
      },
    );
  }

  void onMemberNameTap() {
    Get.toNamed(SetiaModuleRouteNames.managementUserProfile, parameters: {
      'userId': memberComment.memberId,
    });
  }

  void onPhoneButtonTap(final String phoneNumber) async {
    final url = Uri.parse('tel://+98$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void onSMSButtonTap(final String phoneNumber) async {
    final url = Uri.parse('sms://+98$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}
