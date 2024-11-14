import 'package:flutter/material.dart';

import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../infrastructures/utils/date_and_time_utils.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/view/widgets/asset_icon.dart';
import '../../../../shared/view/widgets/news_list_item_image.dart';
import '../../models/news_list_item_view_model.dart';

class NewsListItem extends StatelessWidget {
  final NewsListItemViewModel item;
  final void Function() onItemTap;

  const NewsListItem({
    required this.item,
    required this.onItemTap,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  InkWell _body(final BuildContext context) => InkWell(
        onTap: onItemTap,
        child: Card(
          child: _cardContent(context),
        ),
      );

  Widget _cardContent(final BuildContext context) => Padding(
        padding: Utils.smallPadding,
        child: Row(
          children: [
            _newsPreview(context),
            Utils.smallHorizontalSpacer,
            _arrowIcon(),
          ],
        ),
      );

  Widget _newsPreview(final BuildContext context) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imageAndTitle(context),
            Utils.mediumVerticalSpacer,
            _shortDescription(context),
            Utils.smallVerticalSpacer,
            _releaseDate(),
          ],
        ),
      );

  Widget _releaseDate() => Row(
        children: [
          const AssetIcon(
            path: 'lib/assets/menu_icons/calendar.png',
            size: 23,
          ),
          Utils.tinyHorizontalSpacer,
          Text(
            'تاریخ انتشار : ${DateAndTimeUtils.standardIranDateFormat(
              item.releaseDate,
            )}',
          ),
        ],
      );

  Widget _shortDescription(final BuildContext context) => Text(
        item.content,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: CustomMilkyTheme.textColor.withOpacity(0.8),
            ),
      );

  Widget _imageAndTitle(final BuildContext context) => Row(
        children: [
          NewsListItemImage(
            src: item.imageId,
          ),
          Utils.smallHorizontalSpacer,
          _title(context),
        ],
      );

  Widget _title(final BuildContext context) => Expanded(
        child: Text(
          item.title,
          style: Theme.of(context).textTheme.titleMedium,
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
