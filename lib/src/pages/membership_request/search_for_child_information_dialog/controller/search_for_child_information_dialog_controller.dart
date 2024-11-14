import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../shared/membership_request_child_information_view_model.dart';
import '../repository/search_for_child_information_dialog_repository.dart';

class SearchForChildInformationDialogController extends GetxController {
  final _repository = SearchForChildInformationDialogRepository();

  final RxBool isLoading = false.obs;

  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();

  void onSearchButtonTap() async {
    if (formKey.currentState!.validate()) {
      await _checkMemberIsAvailable();
    }
  }

  Future<void> _checkMemberIsAvailable() async {
    isLoading.value = true;
    final resultOrException = await _repository.getChildInformation(
      controller.text,
    );

    resultOrException.fold(
      (final exception) => isLoading.value = false,
      (final result) {
        final model = _createModel(result.id);
        Get.back(result: model);
      },
    );
  }

  MembershipRequestChildInformationViewModel _createModel(final String id) =>
      MembershipRequestChildInformationViewModel(
        id: id,
        nationalCode: controller.text,
      );
}
