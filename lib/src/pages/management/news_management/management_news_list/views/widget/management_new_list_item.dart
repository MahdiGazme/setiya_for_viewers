import 'package:flutter/material.dart';

import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/date_and_time_utils.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../../../../shared/view/widgets/asset_icon.dart';
import '../../../../../shared/view/widgets/news_list_item_image.dart';
import '../../models/management_news_list_item_view_model.dart';

class ManagementNewsListItem extends StatelessWidget {
  final ManagementNewsListItemViewModel item;
  final void Function(int newsId) onItemTap;
  final void Function(int newsId) onItemLongPress;
  final bool isSelected;

  const ManagementNewsListItem({
    required this.item,
    required this.onItemTap,
    required this.onItemLongPress,
    this.isSelected = false,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  InkWell _body(final BuildContext context) => InkWell(
        onTap: () => onItemTap.call(item.newsId),
        onLongPress: () => onItemLongPress.call(item.newsId),
        child: Stack(
          children: [
            _card(context),
            if (isSelected) _selectedIndicator(),
          ],
        ),
      );

  Card _card(final BuildContext context) => Card(
        child: Padding(
          padding: Utils.smallPadding,
          child: Row(
            children: [
              _newsPreview(context),
              Utils.smallHorizontalSpacer,
              _arrowIcon(),
            ],
          ),
        ),
      );

  Widget _selectedIndicator() => PositionedDirectional(
        top: 4.5,
        end: 4.5,
        child: DecoratedBox(
          decoration: _selectedIndicatorDecoration(),
          child: Icon(
            Icons.done,
            color: CustomMilkyTheme.secondaryColor,
          ),
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
            _releaseAndExpireDate(context),
          ],
        ),
      );

  Widget _releaseAndExpireDate(final BuildContext context) => Row(
        children: [
          Expanded(
            child: _releaseDate(context),
          ),
          if (item.expireDate != null) _expireDate(context),
        ],
      );

  Widget _expireDate(final BuildContext context) => Row(
        children: [
          const AssetIcon(
            path: 'lib/assets/menu_icons/expireDate.png',
            size: 18,
          ),
          Utils.tinyHorizontalSpacer,
          Text(
            'تاریخ انقضا : ${DateAndTimeUtils.standardIranDateFormat(
              item.expireDate!,
            )}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      );

  Widget _releaseDate(final BuildContext context) => Row(
        children: [
          const AssetIcon(
            path: 'lib/assets/menu_icons/calendar.png',
            size: 18,
          ),
          Utils.tinyHorizontalSpacer,
          Text(
            'تاریخ انتشار : ${DateAndTimeUtils.standardIranDateFormat(
              item.releaseDate,
            )}',
            style: Theme.of(context).textTheme.bodySmall,
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

  BoxDecoration _selectedIndicatorDecoration() => BoxDecoration(
        borderRadius: const BorderRadiusDirectional.only(
          topEnd: Radius.circular(CustomMilkyTheme.borderRadiusSemiRound,),
          bottomStart: Radius.circular(CustomMilkyTheme.borderRadiusSemiRound,),
        ),
        color: CustomMilkyTheme.primaryColor,
      );
}
