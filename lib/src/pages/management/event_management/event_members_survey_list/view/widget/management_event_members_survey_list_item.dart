import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../../../../shared/view/widgets/setia_avatar_selector/views/setia_avatar_selector.dart';
import '../../models/management_event_members_survey_list_view_model.dart';

class ManagementEventMembersSurveyListItem extends StatelessWidget {
  final ManagementEventMembersSurveyListViewModel item;
  final void Function() onTap;

  const ManagementEventMembersSurveyListItem({
    required this.item,
    required this.onTap,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => Card(
        child: InkWell(
            borderRadius: BorderRadius.circular(
              CustomMilkyTheme.borderRadiusSemiRound,
            ),
            onTap: onTap,
            child: _content(context)),
      );

  Widget _content(final BuildContext context) => Padding(
        padding: Utils.smallPadding,
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _avatarAndFullNameAndRate(context),
                if (item.shortComment != null) _shortComment(context)
              ],
            ),
            Icon(
              Icons.keyboard_arrow_left,
              color: CustomMilkyTheme.infoColor,
            ),
          ],
        ),
      );

  Widget _avatarAndFullNameAndRate(final BuildContext context) => Row(
        children: [
          _avatar(),
          Utils.smallHorizontalSpacer,
          _information(context),
        ],
      );

  Widget _shortComment(final BuildContext context) => Column(
        children: [
          Utils.smallVerticalSpacer,
          Text(
            item.shortComment!.length < 50
                ? item.shortComment!
                : '${item.shortComment!}...',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: CustomMilkyTheme.infoColor,
                ),
          ),
        ],
      );

  Widget _information(final BuildContext context) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _fullName(context),
            Utils.tinyVerticalSpacer,
            _rate(context),
          ],
        ),
      );

  Widget _fullName(final BuildContext context) => Text(
        '${item.firstName} ${item.lastName}',
        style: Theme.of(context).textTheme.bodyLarge,
      );

  Widget _rate(final BuildContext context) => RatingBar.builder(
        ignoreGestures: true,
        initialRating: item.rate,
        direction: Axis.horizontal,
        itemCount: 5,
        itemSize: 23,
        unratedColor: CustomMilkyTheme.accentColor.withOpacity(0.4),
        itemBuilder: (final context, final index) => Icon(
          Icons.star_rate_rounded,
          color: CustomMilkyTheme.primaryColor,
        ),
        onRatingUpdate: (final value) {},
      );

  Widget _avatar() => SetiaAvatarSelector(
        avatarId: item.avatarId,
        memberName: '${item.firstName} ${item.lastName}',
        selectorMode: false,
        borderRadios: CustomMilkyTheme.borderRadiusSemiRound,
        size: 55,
      );
}
