import 'package:get/get.dart';
import '../../../../setia_module.dart';
import '../../change_password/controller/change_password_controller.dart';
import '../../change_password/views/change_password.dart';
import '../../shared/models/enums/page_state_enum.dart';
import '../models/dto/change_avatar_dto.dart';
import '../models/public_profile_view_model.dart';
import '../repository/public_profile_repository.dart';

class PublicProfileController extends GetxController {
  final _repository = PublicProfileRepository();
  late PublicProfileViewModel? profileData;
  Rxn<String> avatarId = Rxn(null);
  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;

  @override
  void onInit() async {
    await getProfileData();
    super.onInit();
  }

  Future<void> getProfileData() async {
    state.value = PageStateEnum.loading;
    final resultOrException = await _repository.getProfileData();
    resultOrException.fold(
      (final exception) => state.value = PageStateEnum.retry,
      (final result) {
        profileData = result;
        avatarId.value = profileData?.avatarId;
        state.value = PageStateEnum.success;
      },
    );
  }

  void onAuthorizeButtonTap() async {
    final result =
        await Get.toNamed(SetiaModuleRouteNames.addMembershipRequest);
    if (result != null && result as bool) {
      await getProfileData();
    }
  }

  void onEditMembershipRequestTap() async {
    final result =
        await Get.toNamed(SetiaModuleRouteNames.editMembershipRequest);
    if (result != null && result as bool) {
      await getProfileData();
    }
  }

  void onChangePasswordTap() {
    Get.dialog(const ChangePassword(ChangePasswordController.new));
  }

  void onMemberEventManagementTap() {
    Get.toNamed(SetiaModuleRouteNames.memberEventsHistoryList);
  }

  void onAdditionalInformationTap() async {
    final result = await Get.toNamed(
      SetiaModuleRouteNames.memberAdditionalInformation,
    );
    if (result != null && (result as bool)) {
      await getProfileData();
    }
  }

  Future<void> onAvatarUploaded(final String newAvatarId) async {
    final dto = ChangeAvatarDto(avatarId: newAvatarId);
    final resultOrException = await _repository.changeAvatar(dto);

    resultOrException.fold(
      (final exception) => null,
      (final result) => avatarId.value = newAvatarId,
    );
  }

  Future<void> onAvatarDeleted() async {
    final dto = ChangeAvatarDto(avatarId: null);
    final resultOrException = await _repository.deleteAvatar(dto);

    resultOrException.fold(
      (final exception) => null,
      (final result) => avatarId.value = null,
    );
  }
}
