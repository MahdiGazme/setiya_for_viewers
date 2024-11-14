import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../infrastructures/role_management/setiya_role_enum.dart';
import '../../../shared/models/enums/page_state_enum.dart';
import '../../../shared/view/widgets/setiya_snackbar.dart';
import '../models/dto/change_role_dto.dart';
import '../models/member_role_view_model.dart';
import '../repository/change_role_dialog_repository.dart';

class ChangeRoleDialogController extends GetxController {
  final _repository = ChangeRoleDialogRepository();
  final state = PageStateEnum.loading.obs;
  final RxBool isLoading = false.obs;
  final String memberId;
  late MemberRoleViewModel lastRole;
  final Rxn<SetiyaRoleEnum> role = Rxn(null);

  ChangeRoleDialogController({required this.memberId});

  @override
  void onInit() async {
    await getMemberCurrentRole();
    super.onInit();
  }

  Future<void> getMemberCurrentRole() async {
    state.value = PageStateEnum.loading;
    final resultORException = await _repository.getCurrentRole(memberId);

    resultORException.fold(
      (final exception) => state.value = PageStateEnum.retry,
      (final result) {
        role.value = SetiyaRoleEnum.fromValue(result.role);
        lastRole = result;
        state.value = PageStateEnum.success;
      },
    );
  }

  Future<void> onChangeRoleButtonTap() async {
    if (lastRole.role != role.value!.value) {
      final dto = _createDto();
      await changeRole(dto);
    } else {
      SetiyaSnackbar().showSnackbar(
        LocaleKeys.setia_module_shared_commons_warning.tr,
        LocaleKeys
            .setia_module_pages_management_change_role_dialog_same_role_alert
            .tr,
        status: SetiyaSnackbarStatus.warning,
      );
    }
  }

  ChangeRoleDto _createDto() => ChangeRoleDto(role: role.value!.value);

  Future<void> changeRole(final ChangeRoleDto dto) async {
    isLoading.value = true;
    final resultOrException = await _repository.changeRole(
      dto,
      memberId,
    );

    resultOrException.fold(
      (final exception) => isLoading.value = false,
      (final result) => Get.back(
        result: true,
      ),
    );
  }
}
