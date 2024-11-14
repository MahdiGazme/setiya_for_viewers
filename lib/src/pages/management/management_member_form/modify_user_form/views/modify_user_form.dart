import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/view/widgets/page_state.dart';
import '../../../../shared/view/widgets/scaffold_body_container.dart';
import '../../../../shared/view/widgets/secondary_app_bar.dart';
import '../../../../shared/view/widgets/setiya_elevated_button.dart';
import '../controllers/add_user_controller.dart';
import '../controllers/base_user_controller.dart';
import 'widgets/member_information_form_item.dart';

class ModifyUserForm<T extends BaseUserController> extends GetView<T> {
  const ModifyUserForm({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        backgroundColor: CustomMilkyTheme.primaryColor,
        appBar: _appBar(),
        body: ScaffoldBodyContainer(
          child: _state(context),
        ),
      );

  Widget _state(final BuildContext context) => PageStateProvider(
        page: _body,
        onRetry: controller.onRetry,
        state: controller.state,
      );

  Widget _body() => Column(
        children: [
          _infoText(),
          Utils.mediumVerticalSpacer,
          MemberInformationForm<T>(),
          Utils.mediumVerticalSpacer,
          _addEditButton(),
        ],
      );

  Widget _addEditButton() => SetiyaElevatedButton(
        onPressed: controller.onButtonTap,
        showLoading: controller.isUploadingData.value,
        child: Text(
          controller is AddUserController ? 'ثبت کاربر' : 'ویرایش کاربر',
        ),
      );

  Widget _infoText() => Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: CustomMilkyTheme.accentColor,
          ),
          Utils.smallHorizontalSpacer,
          const Text('لطفا همه بخش های ستاره دار را کامل کنید'),
        ],
      );

  PreferredSizeWidget _appBar() => SecondaryAppBar(
        title: Text(
          controller is AddUserController ? 'افزودن کاربر' : 'ویرایش کاربر',
        ),
      );
}
