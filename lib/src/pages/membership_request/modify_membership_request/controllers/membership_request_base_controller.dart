import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../shared/models/enums/member_marriage_status_enum.dart';
import '../../../shared/models/enums/page_state_enum.dart';
import '../../../shared/view/widgets/setiya_snackbar.dart';
import '../../search_for_child_information_dialog/controller/search_for_child_information_dialog_controller.dart';
import '../../search_for_child_information_dialog/view/search_for_child_information_dialog.dart';
import '../../shared/membership_request_child_information_view_model.dart';

abstract class MembershipRequestBaseController extends GetxController {
  final Rx<PageStateEnum> state = PageStateEnum.success.obs;

  final RxBool isUploading = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<FormState> searchByNationalCodeDialogFormKey = GlobalKey();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final mobileNumber = TextEditingController();
  Rxn<Jalali> birthDate = Rxn(null);
  Rxn<String> avatarId = Rxn(null);
  RxList<MembershipRequestChildInformationViewModel> children =
      <MembershipRequestChildInformationViewModel>[].obs;
  final Rx<MemberMarriageStatusEnum> marriageStatus =
      MemberMarriageStatusEnum.single.obs;

  Future<void> onRetry();

  void onSubmitButtonTap();

  void onAddChildButtonTap() async {
    final result = await Get.dialog(
      const SearchForChildInformationDialog(
        SearchForChildInformationDialogController.new,
      ),
    );

    if (result != null) {
      _onNationalCodeChecked(
        result as MembershipRequestChildInformationViewModel,
      );
    }
  }

  void onSearchNationalCodeTap(final String nationalCode) {
    if (searchByNationalCodeDialogFormKey.currentState!.validate()) {
      Get.back(
        result: nationalCode,
      );
    }
  }

  void _onNationalCodeChecked(
    final MembershipRequestChildInformationViewModel item,
  ) async {
    final child = children.where(
      (final element) => element.nationalCode == item.nationalCode,
    );

    if (child.isEmpty) {
      children.add(item);
    } else {
      SetiyaSnackbar().showSnackbar(
        'هشدار',
        'شخص مورد نظر در حال حاظر در لیست فرزندان شما قرار دارد',
        status: SetiyaSnackbarStatus.warning,
      );
    }
  }

  void onRemoveChildTap(final String id);
}
