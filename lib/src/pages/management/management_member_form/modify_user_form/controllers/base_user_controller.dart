import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../shared/models/enums/member_marriage_status_enum.dart';
import '../../../../shared/models/enums/page_state_enum.dart';
import '../../../../shared/models/management_child_view_model.dart';
import '../../management_member_form_assignable_children_list_bottom_sheet/controller/management_member_form_children_bottom_sheet_controller.dart';
import '../../management_member_form_assignable_children_list_bottom_sheet/view/management_member_form_children_bottom_sheet.dart';

abstract class BaseUserController extends GetxController {
  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final fatherName = TextEditingController();
  final motherName = TextEditingController();
  final fathersJob = TextEditingController();
  final address = TextEditingController();
  final telephone = TextEditingController();
  final mobileNumber = TextEditingController();
  final motherMobileNumber = TextEditingController();
  final nationalCode = TextEditingController();
  final rate = TextEditingController();
  final memberCode = TextEditingController();

  Rxn<Jalali> birthDate = Rxn(null);

  final children = <ManagementChildViewModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey();

  RxBool isUploadingData = false.obs, isAvatarLoading = false.obs;

  final Rx<MemberMarriageStatusEnum> marriageStatus =
      MemberMarriageStatusEnum.single.obs;

  Rxn<String> avatarId = Rxn(null);

  void onAvatarDeleted() {
    avatarId.value = null;
  }

  Future<void> onRetry();

  Future<void> onButtonTap();

  Future<void> onAddChildButtonTap() async {
    final result = await Get.bottomSheet(
      backgroundColor: CustomMilkyTheme.secondaryColor,
      persistent: true,
      useRootNavigator: true,
      ManagementMemberFormChildrenBottomSheet(
        () => ManagementMemberFormChildrenBottomSheetController(
          oldChildren: children,
          motherId: Get.parameters['userId'],
        ),
      ),
    );

    if (result != null) {
      children.clear();
      children.addAll(result);
    }
  }
}
