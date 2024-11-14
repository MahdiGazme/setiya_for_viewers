import 'package:flutter/material.dart';

import '../../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../../infrastructures/utils/date_and_time_utils.dart';
import '../../../../../../../infrastructures/utils/utils.dart';
import '../../../../../../shared/view/widgets/asset_icon.dart';
import '../../../../../../shared/view/widgets/events/event_contact_type_widget.dart';
import '../../../../../../shared/view/widgets/events/events_list_item_image.dart';
import '../../models/active_events_view_model.dart';

class ActiveEventListItem extends StatelessWidget {
  final ActiveEventsListItemViewModel item;
  final void Function() onTap;

  const ActiveEventListItem({
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
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
