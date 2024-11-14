import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/view/widgets/page_state.dart';
import '../../../../shared/view/widgets/scaffold_body_container.dart';
import '../../../../shared/view/widgets/secondary_app_bar.dart';
import '../../../../shared/view/widgets/setia_avatar_selector/views/setia_avatar_selector.dart';
import '../controller/event_member_comment_details_controller.dart';

class EventMemberCommentDetails
    extends GetView<EventMemberCommentDetailsController> {
  const EventMemberCommentDetails({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        appBar: const SecondaryAppBar(
          title: Text('بازخورد'),
        ),
        backgroundColor: CustomMilkyTheme.primaryColor,
        body: _body(context),
      );

  ScaffoldBodyContainer _body(final BuildContext context) =>
      ScaffoldBodyContainer(
        child: PageStateProvider(
          state: controller.state,
          onRetry: controller.getCommentDetails,
          page: () => _content(context),
        ),
      );

  Widget _content(final BuildContext context) => Card(
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _actions(context),
              _avatar(),
              Utils.mediumVerticalSpacer,
              _nameAndPhoneNumber(context),
              Utils.mediumVerticalSpacer,
              _rate(context),
              if (controller.memberComment.comment != null) _comment()
            ],
          ),
        ),
      );

  Widget _avatar() => SetiaAvatarSelector(
        selectorMode: false,
        size: 150,
        borderRadios: CustomMilkyTheme.borderRadiusCircular,
        avatarId: controller.memberComment.avatarId,
        memberName: '${controller.memberComment.firstName} '
            '${controller.memberComment.lastName}',
      );

  Widget _comment() => Column(
        children: [
          Utils.mediumVerticalSpacer,
          DecoratedBox(
            decoration: _commentDecoration(),
            child: Padding(
              padding: Utils.smallPadding,
              child: Text(controller.memberComment.comment!),
            ),
          ),
        ],
      );

  BoxDecoration _commentDecoration() => BoxDecoration(
        color: CustomMilkyTheme.primaryColor.shade300,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );

  Widget _actions(final BuildContext context) => Row(
        children: [
          _phoneButton(),
          _messageButton(),
        ],
      );

  Widget _messageButton() => IconButton(
        onPressed: () =>
            controller.onSMSButtonTap(controller.memberComment.mobileNumber),
        icon: Icon(
          Icons.message_rounded,
          color: CustomMilkyTheme.accentColor,
        ),
      );

  Widget _phoneButton() => IconButton(
        onPressed: () =>
            controller.onPhoneButtonTap(controller.memberComment.mobileNumber),
        icon: Icon(
          Icons.call_rounded,
          color: CustomMilkyTheme.accentColor,
        ),
      );

  Widget _nameAndPhoneNumber(final BuildContext context) => Padding(
        padding: Utils.tinyPadding,
        child: Column(
          children: [
            _name(context),
            Utils.smallVerticalSpacer,
            _phoneNumber(context),
          ],
        ),
      );

  Widget _phoneNumber(final BuildContext context) => Text(
        '0${controller.memberComment.mobileNumber}',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: CustomMilkyTheme.textColor.withOpacity(0.6),
            ),
      );

  Widget _name(final BuildContext context) => InkWell(
        onTap: controller.onMemberNameTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            nameText(context),
            Utils.smallVerticalSpacer,
            _arrowIcon(),
          ],
        ),
      );

  Widget _arrowIcon() => Icon(
        Icons.arrow_right_rounded,
        color: CustomMilkyTheme.textColor,
      );

  Widget nameText(final BuildContext context) => Text(
        '${controller.memberComment.firstName} '
        '${controller.memberComment.lastName}',
        style: Theme.of(context).textTheme.titleMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget _rate(final BuildContext context) => RatingBar.builder(
        ignoreGestures: true,
        initialRating: controller.memberComment.rate,
        direction: Axis.horizontal,
        itemCount: 5,
        itemSize: 50,
        unratedColor: CustomMilkyTheme.accentColor.withOpacity(0.4),
        itemBuilder: (final context, final index) => Icon(
          Icons.star_rate_rounded,
          color: CustomMilkyTheme.primaryColor,
        ),
        onRatingUpdate: (final value) {},
      );
}
