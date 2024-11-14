import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../infrastructures/utils/utils.dart';

class NewsImagesPageView extends StatelessWidget {
  final PageController controller;

  final List<String> imageIds;

  const NewsImagesPageView({
    required this.imageIds,
    required this.controller,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Column(
        children: [
          _imagesPageView(context),
          Utils.smallVerticalSpacer,
          _pageIndicators()
        ],
      );

  Widget _imagesPageView(final BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.width <
                Utils.defaultResponsiveMaxWidth
            ? 9 *
                (MediaQuery.of(context).size.width - Utils.smallSpace * 2) /
                16
            : 9 * (Utils.defaultResponsiveMaxWidth - Utils.smallSpace * 2) / 16,
        child: PageView.builder(
          itemCount: imageIds.length,
          controller: controller,
          itemBuilder: (final context, final index) =>
              _pageViewItem(index, context),
        ),
      );

  Widget _pageViewItem(final int index, final BuildContext context) => Card(
        color: CustomMilkyTheme.primaryColor.shade200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            CustomMilkyTheme.borderRadiusSemiRound,
          ),
          child: Image.network(
            RepositoryUrls.downloadDocumentUrl(imageIds[index]),
            fit: BoxFit.fitHeight,
          ),
        ),
      );

  Widget _pageIndicators() => SmoothPageIndicator(
        count: imageIds.length,
        effect: WormEffect(
            dotColor: CustomMilkyTheme.primaryColor.shade300,
            activeDotColor: CustomMilkyTheme.primaryColor,
            dotHeight: Utils.smallSpace,
            dotWidth: Utils.smallSpace,
            spacing: Utils.tinySpace),
        controller: controller,
      );
}
