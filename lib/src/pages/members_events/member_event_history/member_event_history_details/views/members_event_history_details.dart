import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/models/enums/member_event_execution_status_enum.dart';
import '../../../../shared/view/widgets/asset_icon.dart';
import '../../../../shared/view/widgets/events/event_image.dart';
import '../../../../shared/view/widgets/page_state.dart';
import '../../../../shared/view/widgets/scaffold_body_container.dart';
import '../../../../shared/view/widgets/secondary_app_bar.dart';
import '../controller/members_event_history_details_controller.dart';
import 'widgets/members_event_history_details_information.dart';

class MembersEventHistoryDetails
    extends GetView<MembersEventHistoryDetailsController> {
  const MembersEventHistoryDetails({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        appBar: _appbar(),
        backgroundColor: CustomMilkyTheme.primaryColor,
        body: _body(context),
      );

  SecondaryAppBar _appbar() => const SecondaryAppBar(
        title: Text('رویداد'),
      );

  Widget _body(
    final BuildContext context,
  ) =>
      ScaffoldBodyContainer(
        child: PageStateProvider(
          state: controller.state,
          onRetry: controller.getEventDetails,
          page: () => _content(context),
        ),
      );

  Widget _content(final BuildContext context) => SingleChildScrollView(
        child: _eventElement(context),
      );

  Widget _eventElement(final BuildContext context) => Card(
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _image(),
              Utils.mediumVerticalSpacer,
              _title(context),
              Utils.smallVerticalSpacer,
              const MembersEventHistoryDetailsInformation(),
              Utils.mediumVerticalSpacer,
              _description(context),
              Utils.smallVerticalSpacer,
              _priceAndCancelButton(context),
            ],
          ),
        ),
      );

  Widget _priceAndCancelButton(final BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _price(context),
          if (controller.eventDetails.executionStatus ==
                  MemberEventExecutionStatusEnum.await ||
              controller.eventDetails.executionStatus ==
                  MemberEventExecutionStatusEnum.registered)
            _cancelEventRegistrationButton()
        ],
      );

  Widget _cancelEventRegistrationButton() => ElevatedButton(
        onPressed: controller.onCancelRegistrationButtonTap,
        child: const Text('انصراف'),
      );

  Widget _image() => EventImage(
        giftRate: controller.eventDetails.giftRate,
        imageId: controller.eventDetails.imageId,
      );

  Widget _description(final BuildContext context) => DecoratedBox(
        decoration: _descriptionsDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _descriptionLabel(),
              Utils.smallVerticalSpacer,
              _descriptionText(context),
            ],
          ),
        ),
      );

  BoxDecoration _descriptionsDecoration() => BoxDecoration(
        color: CustomMilkyTheme.primaryColor.shade300,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,        ),
      );

  Widget _descriptionText(final BuildContext context) => Text(
        controller.eventDetails.description,
        style: Theme.of(context).textTheme.bodySmall,
      );

  Widget _descriptionLabel() => const Row(
        children: [
          AssetIcon(
            path: 'lib/assets/menu_icons/event_description.png',
            size: 18,
          ),
          Utils.smallHorizontalSpacer,
          Text('توضیحات:'),
        ],
      );

  Widget _title(final BuildContext context) => Text(
        controller.eventDetails.title,
        style: Theme.of(context).textTheme.titleSmall,
      );

  Widget _price(final BuildContext context) => Text(
        controller.eventDetails.price == null
            ? 'رایگان'
            : 'هزینه شرکت:  '
                '${Utils.treeDigitSeparate(
                controller.eventDetails.price.toString(),
              )}'
                ' تومان',
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: CustomMilkyTheme.primaryColor,
            ),
      );
}
