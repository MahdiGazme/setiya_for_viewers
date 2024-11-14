import 'package:flutter/material.dart';

import '../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../asset_icon.dart';

class EventsListItemImage extends StatelessWidget {
  final String? src;

  const EventsListItemImage({
    required this.src,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
        child: Container(
          height: 63,
          width: 112,
          color: CustomMilkyTheme.primaryColor.shade300,
          child: src != null ? _image() : _emptyWidget(),
        ),
      );

  Widget _emptyWidget() => const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 3,
        ),
        child: AssetIcon(
          path: 'lib/assets/images/logo_secondary.png',
        ),
      );

  Widget _image() => Image.network(
        RepositoryUrls.downloadDocumentUrl(src!),
        fit: BoxFit.cover,
      );
}
