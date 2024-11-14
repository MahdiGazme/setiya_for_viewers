import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../infrastructures/utils/utils.dart';
import '../../shared/view/widgets/page_state.dart';
import '../../shared/view/widgets/scaffold_body_container.dart';
import '../../shared/view/widgets/secondary_app_bar.dart';
import '../../shared/view/widgets/setiya_elevated_button.dart';
import '../controller/member_additional_information_controller.dart';
import 'widget/additional_home_information_form.dart';
import 'widget/additional_parrents_information_form.dart';

class MemberAdditionalInformation
    extends GetView<MemberAdditionalInformationController> {
  const MemberAdditionalInformation({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        appBar: const SecondaryAppBar(
          title: Text('اطلاعات تکمیلی'),
        ),
        backgroundColor: CustomMilkyTheme.primaryColor,
        body: _body(context),
      );

  Widget _body(final BuildContext context) => ScaffoldBodyContainer(
        child: PageStateProvider(
          state: controller.state,
          onRetry: controller.getLastAdditionalInformation,
          page: () => Column(
            children: [
              _form(context),
              _buttons(),
            ],
          ),
        ),
      );

  Widget _form(final BuildContext context) => Expanded(
        child: SingleChildScrollView(
          child: Card(
            child: Padding(
              padding: Utils.smallPadding,
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    _hint(context),
                    Utils.smallVerticalSpacer,
                    const AdditionalParentsInformationForm(),
                    Utils.smallVerticalSpacer,
                    const AdditionalHomeInformationForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget _hint(final BuildContext context) => Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: CustomMilkyTheme.accentColor,
          ),
          Utils.smallHorizontalSpacer,
          Text(
            'تکمیل اطلاعات به پیشرفت شما در ستیا سرعت می بخشد',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      );

  Widget _buttons() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _backButton(),
          Utils.smallHorizontalSpacer,
          _submitButton(),
        ],
      );

  Widget _backButton() => OutlinedButton(
        onPressed: Get.back,
        child: const Text('بازگشت'),
      );

  Widget _submitButton() => Obx(
        () => SetiyaElevatedButton(
          onPressed: controller.onSubmitButtonTap,
          showLoading: controller.isLoading.value,
          child: const Text('ثبت'),
        ),
      );
}
