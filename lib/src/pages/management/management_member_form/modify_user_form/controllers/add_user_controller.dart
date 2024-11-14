import 'package:get/get.dart';

import '../../../../shared/models/enums/page_state_enum.dart';
import '../models/dto/add_management_member_dto.dart';
import '../repositories/add_user_repository.dart';
import 'base_user_controller.dart';

class AddUserController extends BaseUserController {
  final _repository = AddUserRepository();

  @override
  void onInit() {
    state.value = PageStateEnum.success;
    super.onInit();
  }

  @override
  Future<void> onButtonTap() async {
    if (formKey.currentState!.validate()) {
      final memberDto = createDto();
      await addUser(memberDto);
    }
  }

  Future<void> addUser(final AddManagementMemberDto data) async {
    isUploadingData.value = true;
    final resultOrException = await _repository.submitUser(data);
    resultOrException.fold(
      (final exception) {
        isUploadingData.value = false;
      },
      (final result) {
        isUploadingData.value = false;
        Get.back(
          closeOverlays: true,
          result: true,
        );
      },
    );
  }

  AddManagementMemberDto createDto() => AddManagementMemberDto(
        firstName: firstName.text,
        lastName: lastName.text,
        nationalCode: nationalCode.text,
        mobileNumber: mobileNumber.text,
        marriageStatus: marriageStatus.value,
        fatherName: fatherName.text,
        fatherJob: fathersJob.text,
        children: children
            .map(
              (final element) => element.id,
            )
            .toList(),
        motherName: motherName.text,
        address: address.text,
        telephone: telephone.text,
        motherMobile: motherMobileNumber.text,
        avatarId: avatarId.value,
        rate: int.tryParse(rate.text) ?? 0,
        birthDate: birthDate.value!,
        code: int.tryParse(memberCode.text),
      );

  @override
  Future<void> onRetry() async {
    throw UnimplementedError();
  }
}
