import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/view/widgets/page_state.dart';
import '../../../shared/view/widgets/scaffold_body_container.dart';
import '../../../shared/view/widgets/secondary_app_bar.dart';
import '../../../shared/view/widgets/setiya_elevated_button.dart';
import '../controllers/membership_request_add_controller.dart';
import '../controllers/membership_request_base_controller.dart';
import 'widgets/membership_request_form.dart';

class ModifyMembershipRequest<T extends MembershipRequestBaseController>
    extends GetView<T> {
  const ModifyMembershipRequest({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        appBar: const SecondaryAppBar(
          title: Text('درخواست احراز هویت'),
        ),
        backgroundColor: CustomMilkyTheme.primaryColor,
        body: _body(),
      );

  Widget _body() => ScaffoldBodyContainer(
        child: PageStateProvider(
          state: controller.state,
          page: _content,
          onRetry: controller.onRetry,
        ),
      );

  Widget _content() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _form(),
          Utils.mediumVerticalSpacer,
          _button(),
        ],
      );

  Widget _button() => Obx(
        () => SetiyaElevatedButton(
          onPressed: controller.onSubmitButtonTap,
          showLoading: controller.isUploading.value,
          child: Text(
            T == MembershipRequestAddController
                ? 'ثبت درخواست'
                : 'ویرایش درخواست',
          ),
        ),
      );

  Widget _form() => Expanded(
        child: MembershipRequestForm<T>(),
      );
}
