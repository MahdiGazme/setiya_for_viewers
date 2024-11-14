import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/date_and_time_utils.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/models/management_child_view_model.dart';
import '../../../shared/view/widgets/information_widget.dart';
import '../../../shared/view/widgets/management_children_list_item.dart';
import '../../../shared/view/widgets/page_state.dart';
import '../../../shared/view/widgets/scaffold_body_container.dart';
import '../../../shared/view/widgets/secondary_app_bar.dart';
import '../../../shared/view/widgets/setia_avatar_selector/views/setia_avatar_selector.dart';
import '../controller/authorize_request_controller.dart';

class AuthorizeRequest extends GetView<AuthorizeRequestController> {
  const AuthorizeRequest({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        appBar: SecondaryAppBar(
          title: Text(
            LocaleKeys.setia_module_pages_management_authorize_request_title.tr,
          ),
        ),
        backgroundColor: CustomMilkyTheme.primaryColor,
        body: ScaffoldBodyContainer(
          child: PageStateProvider(
            onRetry: controller.getRequest,
            state: controller.state,
            page: () => _content(context),
          ),
        ),
      );

  Column _content(final BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _requestDetails(context),
          Utils.mediumVerticalSpacer,
          _button(),
        ],
      );

  Widget _requestDetails(final BuildContext context) => Expanded(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Card(
            child: Padding(
              padding: Utils.smallPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _actions(),
                  _avatar(),
                  Utils.smallVerticalSpacer,
                  _nameAndPhoneNumber(context),
                  Utils.mediumVerticalSpacer,
                  _information(context),
                  if (controller.requestDetails.children.isNotEmpty)
                    _childField()
                ],
              ),
            ),
          ),
        ),
      );

  Widget _actions() => Row(
        children: [
          _phoneButton(),
          _messageButton(),
        ],
      );

  Widget _childField() => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Utils.mediumVerticalSpacer,
            Text(
                '${LocaleKeys.setia_module_pages_management_authorize_request_children.tr}'
                ' :'),
            Utils.smallVerticalSpacer,
            _childList(),
          ],
        ),
      );

  Widget _childList() => ListView.builder(
        padding: EdgeInsets.zero,
        primary: false,
        shrinkWrap: true,
        itemCount: controller.requestDetails.children.length,
        itemBuilder: (final context, final index) => _childWidget(
          controller.requestDetails.children[index],
        ),
      );

  Widget _childWidget(final ManagementChildViewModel item) =>
      ManagementChildrenListItem(
        child: item,
        onTap: () => controller.onChildItemTap(item.id),
      );

  Widget _button() => ElevatedButton(
        onPressed: controller.onAnswerButtonTap,
        child: Text(
          LocaleKeys
              .setia_module_pages_management_authorize_request_request_response
              .tr,
        ),
      );

  Widget _information(final BuildContext context) => DecoratedBox(
        decoration: _informationDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            children: [
              _informationTitle(context),
              Utils.largeVerticalSpacer,
              _nationalCode(),
              Utils.mediumVerticalSpacer,
              _birthDate(),
              Utils.mediumVerticalSpacer,
              _marriageStatus(),
            ],
          ),
        ),
      );

  Widget _informationTitle(final BuildContext context) => Text(
        LocaleKeys
            .setia_module_pages_management_authorize_request_request_details.tr,
        style: Theme.of(context).textTheme.bodyLarge,
      );

  Widget _marriageStatus() => UsersInformationWidget(
        label: LocaleKeys.setia_module_shared_members_marriage_status.tr,
        value: controller.requestDetails.marriageStatus.name,
      );

  Widget _birthDate() => UsersInformationWidget(
        label: LocaleKeys.setia_module_shared_members_birthdate.tr,
        value: DateAndTimeUtils.dateWithMountNameFormatter(
            controller.requestDetails.birthDate),
      );

  Widget _nationalCode() => UsersInformationWidget(
        label: LocaleKeys.setia_module_shared_members_national_code.tr,
        value: controller.requestDetails.nationalCode,
      );

  BoxDecoration _informationDecoration() => BoxDecoration(
        color: CustomMilkyTheme.primaryColor.shade300,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );

  Widget _avatar() => SetiaAvatarSelector(
        selectorMode: false,
        memberName: '${controller.requestDetails.firstName}'
            ' ${controller.requestDetails.lastName}',
        avatarId: controller.requestDetails.avatarId,
        borderRadios: 100,
        size: 150,
      );

  Widget _nameAndPhoneNumber(final BuildContext context) => Padding(
        padding: Utils.tinyPadding,
        child: Column(
          children: [
            _nameText(context),
            Utils.smallVerticalSpacer,
            _phoneNumber(context),
          ],
        ),
      );

  Widget _phoneNumber(final BuildContext context) => Text(
        controller.requestDetails.mobileNumber,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: CustomMilkyTheme.textColor.withOpacity(0.6),
            ),
      );

  Widget _nameText(final BuildContext context) => Text(
        '${controller.requestDetails.firstName}'
        ' ${controller.requestDetails.lastName}',
        style: Theme.of(context).textTheme.titleMedium,
      );

  Widget _messageButton() => IconButton(
        onPressed: controller.onSMSButtonTap,
        icon: Icon(
          Icons.message_rounded,
          color: CustomMilkyTheme.accentColor,
        ),
      );

  Widget _phoneButton() => IconButton(
        onPressed: controller.onPhoneButtonTap,
        icon: Icon(
          Icons.call_rounded,
          color: CustomMilkyTheme.accentColor,
        ),
      );
}
