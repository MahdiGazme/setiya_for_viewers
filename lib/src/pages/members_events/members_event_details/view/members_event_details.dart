import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/view/widgets/asset_icon.dart';
import '../../../shared/view/widgets/events/event_image.dart';
import '../../../shared/view/widgets/page_state.dart';
import '../../../shared/view/widgets/scaffold_body_container.dart';
import '../../../shared/view/widgets/secondary_app_bar.dart';
import '../controller/members_event_details_controller.dart';
import 'widgets/event_details.dart';

class MembersEventDetails extends GetView<MembersEventDetailsController> {
  const MembersEventDetails({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        appBar: const SecondaryAppBar(
          title: Text('رویداد'),
        ),
        backgroundColor: CustomMilkyTheme.primaryColor,
        body: _body(context),
      );

  Widget _body(final BuildContext context) => ScaffoldBodyContainer(
        child: PageStateProvider(
          state: controller.state,
          onRetry: controller.getEventDetails,
          page: () => _bodyContent(context),
        ),
      );

  Widget _bodyContent(final BuildContext context) => SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: Utils.smallPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                EventImage(
                  imageId: controller.eventDetails.imageId,
                  giftRate: controller.eventDetails.giftRate,
                ),
                Utils.smallVerticalSpacer,
                _title(context),
                Utils.largeVerticalSpacer,
                const DetailsWidget(),
                Utils.mediumVerticalSpacer,
                _description(context),
                Utils.mediumVerticalSpacer,
                _submitButtonAndPrice(context)
              ],
            ),
          ),
        ),
      );

  Widget _submitButtonAndPrice(final BuildContext context) => Row(
        children: [
          if (controller.eventDetails.price != null) _price(context),
          _submitButton(),
        ],
      );

  Widget _submitButton() => Expanded(
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: ElevatedButton(
            onPressed: controller.onSubmitButtonTap,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.edit),
                Utils.smallHorizontalSpacer,
                Text(
                  'ثبت نام',
                ),
              ],
            ),
          ),
        ),
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

  Widget _description(final BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: CustomMilkyTheme.primaryColor.shade300,
          borderRadius: BorderRadius.circular(
            CustomMilkyTheme.borderRadiusSemiRound,
          ),
        ),
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

  Text _descriptionText(final BuildContext context) => Text(
        controller.eventDetails.description,
      );

  Row _descriptionLabel() => const Row(
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
}
