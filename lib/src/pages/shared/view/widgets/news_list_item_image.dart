import 'package:flutter/material.dart';

import '../../../../infrastructures/commons/repository_urls.dart';
import '../../../../infrastructures/themes/custom_milky_theme.dart';

class NewsListItemImage extends StatelessWidget {
  final String src;

  const NewsListItemImage({
    required this.src,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
        child: ColoredBox(
          color: CustomMilkyTheme.primaryColor.shade300,
          child: Image.network(
            RepositoryUrls.downloadDocumentUrl(src),
            fit: BoxFit.cover,
            width: 112,
            height: 63,
          ),
        ),
      );
}
