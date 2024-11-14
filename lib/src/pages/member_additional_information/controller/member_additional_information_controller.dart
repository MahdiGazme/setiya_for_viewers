import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/models/enums/page_state_enum.dart';
import '../model/dto/member_additional_information_dto.dart';
import '../model/member_additional_information_view_model.dart';
import '../repository/member_additional_information_repository.dart';

class MemberAdditionalInformationController extends GetxController {
  final _repository = MemberAdditionalInformationRepository();
  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;
  RxBool isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  final fatherName = TextEditingController();
  final fatherJob = TextEditingController();
  final motherName = TextEditingController();
  final motherMobileNumber = TextEditingController();
  final telephone = TextEditingController();
  final address = TextEditingController();

  @override
  void onInit() async {
    await getLastAdditionalInformation();
    super.onInit();
  }

  Future<void> getLastAdditionalInformation() async {
    state.value = PageStateEnum.loading;
    final resultOrException = await _repository.getAdditionalInformation();

    resultOrException.fold(
      (final exception) => state.value = PageStateEnum.retry,
      (final result) {
        if (result != null) {
          _initializer(result);
        }
        state.value = PageStateEnum.success;
      },
    );
  }

  void _initializer(final MemberAdditionalInformationViewModel data) {
    fatherName.text = data.fatherName ?? '';
    fatherJob.text = data.fatherJob ?? '';
    motherName.text = data.motherName ?? '';
    motherMobileNumber.text = data.motherMobileNumber ?? '';
    telephone.text = data.telephone ?? '';
    address.text = data.address ?? '';
  }

  void onSubmitButtonTap() async {
    if (formKey.currentState!.validate()) {
      final dto = _createDto();
      await _updateAdditionalInformation(dto);
    }
  }

  Future<void> _updateAdditionalInformation(
    final MemberAdditionalInformationDto dto,
  ) async {
    isLoading.value = true;
    final resultOrException = await _repository.updateAdditionalInformation(
      dto,
    );
    resultOrException.fold(
      (final exception) => isLoading.value = false,
      (final result) => Get.back(
        result: true,
      ),
    );
  }

  MemberAdditionalInformationDto _createDto() => MemberAdditionalInformationDto(
        fatherName: fatherName.text,
        fatherJob: fatherJob.text,
        motherName: motherName.text,
        motherMobileNumber: motherMobileNumber.text,
        telephone: telephone.text,
        address: address.text,
      );
}
