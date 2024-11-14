import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../setia_module.dart';
import '../../../shared/models/enums/page_state_enum.dart';
import '../../../shared/models/member_view_model.dart';
import '../../../shared/view/dialogs/delete_dialog.dart';
import '../../../shared/view/widgets/setiya_snackbar.dart';
import '../../change_role_dialog/controller/change_role_dialog_controller.dart';
import '../../change_role_dialog/views/chane_role_dialog.dart';
import '../repository/management_user_profile_repository.dart';
import '../view/widget/reset_password_dialog.dart';

class ManagementUserProfileController extends GetxController {
  final _repository = ManagementUserProfileRepository();

  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;

  late final String memberId;

  bool hasEdited = false;

  final RxBool isLoading = false.obs, isDeleting = false.obs;

  Rxn<MemberDetailsViewModel> member = Rxn<MemberDetailsViewModel>(null);

  @override
  void onInit() async {
    memberId = Get.parameters['userId']!;
    await getMember();
    super.onInit();
  }

  void onMenuItemSelected(
      final int value, final String firstName, final String lastName) async {
    switch (value) {
      case 0:
        return _onEditButtonTap();
      case 1:
        return _showDeleteDialog(firstName, lastName);
      case 2:
        return _showResetPasswordDialog();
      case 3:
        return _onAccessRoleMenuItemTap();
    }
  }

  Future<void> _showResetPasswordDialog() => Get.dialog(
        const ResetPasswordDialog(),
      );

  Future<void> _onAccessRoleMenuItemTap() async {
    final result = await Get.dialog(
      ChangeRoleDialog(
        () => ChangeRoleDialogController(
          memberId: memberId,
        ),
      ),
    );

    if (result != null && (result as bool)) {
      await getMember();
    }
  }

  Future<void> resetPassword() async {
    isLoading.value = true;
    final resultOrException = await _repository.resetPassword(
      memberId,
    );

    resultOrException.fold(
      (final exception) => isLoading.value = false,
      (final result) {
        Get.back();
        SetiyaSnackbar().showSnackbar(
          'موفق',
          'بازنشانی کلمه عبور موفق بود',
          status: SetiyaSnackbarStatus.success,
        );
      },
    );
  }

  void _showDeleteDialog(
    final String firstName,
    final String lastName,
  ) {
    Get.dialog(
      DeleteDialog(
        onDeleteButtonTap: _onDeleteButtonTap,
        bodyMessage: 'آیا از حذف $firstName $lastName '
            'اطمینان دارید؟',
        isLoading: isDeleting,
      ),
    );
  }

  void onChildItemTap(final String childId) async {
    final result = await Get.toNamed(
        SetiaModuleRouteNames.managementUserProfile,
        parameters: {
          'userId': childId,
        });
    if (result != null && result as bool) {
      await getMember();
    }
  }

  Future<void> getMember() async {
    state.value = PageStateEnum.loading;
    final resultOrException = await _repository.getMemberInformation(
      memberId,
    );

    resultOrException.fold(
      (final exception) => state.value = PageStateEnum.retry,
      (final result) {
        member = Rxn(result);
        state.value = PageStateEnum.success;
      },
    );
  }

  void _onDeleteButtonTap() async {
    isDeleting.value = true;
    final resultOrException = await _repository.deleteMember(
      member.value!.id,
    );

    resultOrException.fold(
      (final l) => isDeleting.value = false,
      (final r) => Get.back(
        result: true,
        closeOverlays: true,
      ),
    );
  }

  Future<bool> onWillPop() async {
    Get.back(
      result: hasEdited,
    );

    return true;
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

  void _onEditButtonTap() async {
    final result =
        await Get.toNamed(SetiaModuleRouteNames.editUser, parameters: {
      'userId': memberId,
    });
    if (result != null && result) {
      hasEdited = true;
      await getMember();
    }
  }
}
