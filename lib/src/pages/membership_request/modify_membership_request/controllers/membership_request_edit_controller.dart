import 'package:get/get.dart';

import '../../../../infrastructures/extensions/iterable_extensions.dart';
import '../../../shared/models/enums/page_state_enum.dart';
import '../../shared/membership_request_child_information_view_model.dart';
import '../models/dto/membership_request_dto.dart';
import '../models/membership_request_view_model.dart';
import '../repositories/membership_request_edit_repository.dart';
import 'membership_request_base_controller.dart';

class MembershipRequestEditController extends MembershipRequestBaseController {
  final _repository = MembershipRequestEditRepository();

  final oldChildren = <MembershipRequestChildInformationViewModel>[];

  @override
  void onInit() async {
    await getOldRequestDetails();
    super.onInit();
  }

  Future<void> getOldRequestDetails() async {
    state.value = PageStateEnum.loading;
    final resultOrException = await _repository.getOldRequestDetails();

    resultOrException.fold(
      (final exception) => state.value = PageStateEnum.retry,
      (final result) {
        initialInformation(result);
        state.value = PageStateEnum.success;
      },
    );
  }

  void initialInformation(
    final MembershipRequestViewModel data,
  ) {
    avatarId.value = data.avatarId;
    firstName.text = data.firstName;
    lastName.text = data.lastName;
    mobileNumber.text = data.mobileNumber;
    birthDate.value = data.birthDate;
    marriageStatus.value = data.marriageStatus;
    children.addAll(data.children);
    oldChildren.addAll(data.children);
  }

  @override
  Future<void> onRetry() => getOldRequestDetails();

  @override
  void onSubmitButtonTap() async {
    if (formKey.currentState!.validate()) {
      final dto = _createDto();
      await _editRequest(dto);
    }
  }

  Future<void> _editRequest(final MembershipRequestDto dto) async {
    isUploading.value = true;
    final resultOrException = await _repository.editOldMembershipRequest(dto);

    resultOrException.fold(
      (final exception) => isUploading.value = false,
      (final result) {
        Get.back(result: true);
      },
    );
  }

  MembershipRequestDto _createDto() => MembershipRequestDto(
        avatarId: avatarId.value,
        birthDate: birthDate.value!,
        firstName: firstName.text,
        lastName: lastName.text,
        mobileNumber: mobileNumber.text,
        marriageStatus: marriageStatus.value,
        newChildren: _newChildren(),
        deletedChildren: _deletedChildren(),
      );

  List<String> _deletedChildren() => oldChildren
      .exceptWhere(
        children,
        (final firstElement, final secondElement) =>
            firstElement.id == secondElement.id,
      )
      .toList()
      .map(
        (final element) => element.id,
      )
      .toList();

  List<String> _newChildren() => children
      .exceptWhere(
        oldChildren,
        (final firstElement, final secondElement) =>
            firstElement.id == secondElement.id,
      )
      .toList()
      .map(
        (final element) => element.id,
      )
      .toList();

  @override
  void onRemoveChildTap(final String id) {
    children.removeWhere(
      (final element) => element.id == id,
    );
  }
}
