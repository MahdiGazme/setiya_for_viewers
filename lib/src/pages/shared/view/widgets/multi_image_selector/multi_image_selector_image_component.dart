import 'package:flutter/material.dart';

import '../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../infrastructures/themes/custom_milky_theme.dart';

class MultiImageSelectorImageComponent extends StatelessWidget {
  final List<String> imageIds;
  final String mainPictureId;
  final void Function(String imageId) onMainPictureChanged;
  final void Function(String imageId) onPictureDeleted;

  const MultiImageSelectorImageComponent({
    required this.imageIds,
    required this.onMainPictureChanged,
    required this.onPictureDeleted,
    required this.mainPictureId,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            imageIds.length,
            (final index) => _managementNewsFormImageItem(
              context: context,
              index: index,
              id: imageIds[index],
            ),
          ),
        ),
      );

  Widget _managementNewsFormImageItem({
    required final BuildContext context,
    required final int index,
    required final String id,
  }) =>
      Stack(
        children: [
          _imageBody(id),
          _menu(context, id),
          if (mainPictureId == id) _mainPictureSign()
        ],
      );

  Widget _mainPictureSign() => PositionedDirectional(
        bottom: 10,
        start: 10,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: CustomMilkyTheme.secondaryColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.star_rate_rounded,
            color: CustomMilkyTheme.primaryColor,
          ),
        ),
      );

  Widget _menu(final BuildContext context, final String id) => Theme(
        data: Theme.of(context).copyWith(useMaterial3: false),
        child: PositionedDirectional(
          top: 0,
          end: 0,
          child: PopupMenuButton(
            color: CustomMilkyTheme.primaryColor.shade50,
            icon: _menuIcon(),
            elevation: 5,
            position: PopupMenuPosition.under,
            shape: _menuShape(),
            onSelected: (final value) => onMenuItemSelected(value as int, id),
            itemBuilder: (final context) => [
              if (imageIds.length > 1) _makeMainPictureMenuItem(context),
              _deleteMenuItem(context),
            ],
          ),
        ),
      );

  Widget _menuIcon() => DecoratedBox(
        decoration: BoxDecoration(
          color: CustomMilkyTheme.infoColor.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.more_vert_rounded,
          color: CustomMilkyTheme.secondaryColor,
        ),
      );

  RoundedRectangleBorder _menuShape() => const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      );

  PopupMenuItem<int> _makeMainPictureMenuItem(final BuildContext context) =>
      PopupMenuItem(
        value: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'به عنوان عکس اصلی',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Icon(
              Icons.star_rate_rounded,
              color: CustomMilkyTheme.textColor,
            )
          ],
        ),
      );

  PopupMenuItem<int> _deleteMenuItem(final BuildContext context) =>
      PopupMenuItem(
        value: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'حذف عکس',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Icon(
              Icons.close,
              color: CustomMilkyTheme.textColor,
            )
          ],
        ),
      );

  Widget _imageBody(final String id) => Card(
        child: SizedBox(
          height: 90,
          width: 160,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              CustomMilkyTheme.borderRadiusSemiRound,
            ),
            child: Image.network(
              RepositoryUrls.downloadDocumentUrl(id),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      );

  void onMenuItemSelected(final int value, final String id) => {
        if (value == 0)
          {
            onMainPictureChanged.call(id),
          }
        else
          {
            onPictureDeleted.call(id),
          }
      };
}
