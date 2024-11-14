import 'package:get/get.dart';
import '../../../../../infrastructures/extensions/iterable_extensions.dart';
import '../../../../shared/models/enums/page_state_enum.dart';
import '../../../../shared/models/management_child_view_model.dart';
import '../../../../shared/models/member_view_model.dart';
import '../models/dto/edit_management_member_dto.dart';
import '../repositories/edit_user_repository.dart';
import 'base_user_controller.dart';

class EditUserController extends BaseUserController {
  late final String userId;

  final _repository = EditUserRepository();

  final List<ManagementChildViewModel> oldChildren = [];

  @override
  void onInit() async {
    userId = Get.parameters['userId']!;
    await getUserInformation();
    super.onInit();
  }

  Future<void> getUserInformation() async {
    state.value = PageStateEnum.loading;
    final resultOrException = await _repository.getUserInformation(userId);

    resultOrException.fold(
      (final exception) => state.value = PageStateEnum.retry,
      (final result) {
        fillData(result);
        state.value = PageStateEnum.success;
      },
    );
  }

  void fillData(final MemberDetailsViewModel value) {
    avatarId.value = value.avatarId;
    marriageStatus.value = value.marriageStatus;
    firstName.text = value.firstName;
    lastName.text = value.lastName;
    fatherName.text = value.fatherName ?? '';
    motherName.text = value.motherName ?? '';
    fathersJob.text = value.fatherJob ?? '';
    address.text = value.address ?? '';
    telephone.text = value.telephone ?? '';
    mobileNumber.text = value.mobileNumber;
    motherMobileNumber.text = value.motherPhoneNumber ?? '';
    rate.text = value.rate == 0 ? '' : value.rate.toString();
    birthDate.value = value.birthDate;
    nationalCode.text = value.nationalCode;
    memberCode.text = value.membershipCode != null ? value.membershipCode.toString() : '';
    children.addAll(value.children);
    oldChildren.addAll(value.children);
  }

  @override
  Future<void> onRetry() async {
    await getUserInformation();
  }

  @override
  Future<void> onButtonTap() async {
    if (formKey.currentState!.validate()) {
      final memberDto = createDto();
      await updateUser(memberDto);
    }
  }

  Future<void> updateUser(final EditManagementMemberDto data) async {
    isUploadingData.value = true;

    final resultOrException =
        await _repository.updateUserInformation(userId, data);

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

  EditManagementMemberDto createDto() => EditManagementMemberDto(
        firstName: firstName.text,
        lastName: lastName.text,
        nationalCode: nationalCode.text,
        mobileNumber: mobileNumber.text,
        marriageStatus: marriageStatus.value,
        newChildren: _newChildren(),
        deletedChildren: _deletedChildren(),
        fatherName: fatherName.text.isEmpty ? null : fatherName.text,
        fatherJob: fathersJob.text.isEmpty ? null : fathersJob.text,
        motherName: motherName.text.isEmpty ? null : motherName.text,
        address: address.text.isEmpty ? null : address.text,
        telephone: telephone.text.isEmpty ? null : telephone.text,
        motherMobile:
            motherMobileNumber.text.isEmpty ? null : motherMobileNumber.text,
        avatarId: avatarId.value,
        rate: int.tryParse(rate.text) ?? 0,
        birthDate: birthDate.value!,
        code: int.tryParse(memberCode.text),
      );

  List<String> _deletedChildren() => oldChildren
      .exceptWhere(
        children,
        (final firstElement, final secondElement) =>
            firstElement.id == secondElement.id,
      )
      .toList()
      .map((final element) => element.id)
      .toList();

  List<String> _newChildren() => children
      .exceptWhere(
        oldChildren,
        (final firstElement, final secondElement) =>
            firstElement.id == secondElement.id,
      )
      .toList()
      .map((final element) => element.id)
      .toList();
}
