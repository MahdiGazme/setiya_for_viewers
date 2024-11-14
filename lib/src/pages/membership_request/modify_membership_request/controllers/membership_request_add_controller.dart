import 'package:get/get.dart';

import '../models/dto/membership_request_dto.dart';
import '../repositories/membership_request_add_repository.dart';
import 'membership_request_base_controller.dart';

class MembershipRequestAddController extends MembershipRequestBaseController {
  final _repository = MembershipRequestAddRepository();

  @override
  Future<void> onRetry() {
    throw UnimplementedError();
  }

  @override
  void onSubmitButtonTap() async {
    if (formKey.currentState!.validate()) {
      final dto = _createDto();
      await _postRequest(dto);
    }
  }

  Future<void> _postRequest(final MembershipRequestDto dto) async {
    isUploading.value = true;
    final resultOrException = await _repository.postMembershipRequest(dto);

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
        newChildren: children
            .map(
              (final element) => element.id,
            )
            .toList(),
        deletedChildren: [],
      );

  @override
  void onRemoveChildTap(final String id) {
    children.removeWhere(
      (final element) => element.id == id,
    );
  }
}
