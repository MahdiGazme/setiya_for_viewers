import 'package:flutter/material.dart';

import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/date_and_time_utils.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../models/enums/events_contact_type_enum.dart';
import '../../models/members_event_list_item_view_model.dart';
import 'asset_icon.dart';
import 'events/event_contact_type_widget.dart';
import 'events/events_list_item_image.dart';
import 'rate_icon.dart';

class MembersEventListItem extends StatelessWidget {
  final MembersEventListViewModel item;
  final void Function() onTap;

  const MembersEventListItem({
    required this.item,
    required this.onTap,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  InkWell _body(final BuildContext context) => InkWell(
        onTap: onTap,
        child: Card(
          child: _cardContent(context),
        ),
      );

  Widget _cardContent(final BuildContext context) => Padding(
        padding: Utils.smallPadding,
        child: Row(
          children: [
            _eventPreview(context),
            Utils.smallHorizontalSpacer,
            _arrowIcon(),
          ],
        ),
      );

  Widget _eventPreview(final BuildContext context) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imageAndTitle(context),
            Utils.smallVerticalSpacer,
            _rateAndDateAndContactType(),
          ],
        ),
      );

  LayoutBuilder _rateAndDateAndContactType() => LayoutBuilder(
        builder: (final context, final constraint) => SizedBox(
          width: constraint.maxWidth,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _minimumRate(context),
              if (item.contactType != EventContactTypEnum.justMembers)
                EventContactTypeWidget(
                  contactType: item.contactType,
                ),
              _releaseDate(context),
            ],
          ),
        ),
      );

  Widget _releaseDate(final BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AssetIcon(
            path: 'lib/assets/menu_icons/calendar.png',
            size: 18,
          ),
          Utils.tinyHorizontalSpacer,
          Text(
            'تاریخ: ${DateAndTimeUtils.standardIranDateFormat(
              item.startDate,
            )}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      );

  Widget _minimumRate(final BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const RateIcon(
            size: 15,
          ),
          Utils.tinyHorizontalSpacer,
          Text(
            'امتیاز مورد نیاز: ${item.minimumRate}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      );

  Widget _imageAndTitle(final BuildContext context) => Row(
        children: [
          EventsListItemImage(src: item.imageId),
          Utils.smallHorizontalSpacer,
          _title(context),
        ],
      );

  Widget _title(final BuildContext context) => Expanded(
        child: Text(
          item.title,
          style: Theme.of(context).textTheme.titleSmall,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      );

  Widget _arrowIcon() => Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 18,
        color: CustomMilkyTheme.accentColor.withOpacity(0.7),
      );
}
