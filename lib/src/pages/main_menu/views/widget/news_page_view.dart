import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../infrastructures/commons/repository_urls.dart';
import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/view/widgets/logo.dart';
import '../../models/news_preview_view_model.dart';

class NewsPageView extends StatelessWidget {
  final PageController pageController;
  final void Function(int imageId) onTap;

  final List<NewsPreviewViewModel> news;

  const NewsPageView({
    required this.news,
    required this.pageController,
    required this.onTap,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Column(
        children: [
          _newsPageView(context),
          Utils.smallVerticalSpacer,
          _pageIndicators()
        ],
      );

  Widget _newsPageView(final BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.width <
                Utils.defaultResponsiveMaxWidth
            ? 9 *
                (MediaQuery.of(context).size.width - Utils.smallSpace * 2) /
                16
            : 9 * (Utils.defaultResponsiveMaxWidth - Utils.smallSpace * 2) / 16,
        width: MediaQuery.of(context).size.width,
        child: PageView.builder(
          itemCount: news.length,
          controller: pageController,
          itemBuilder: (final context, final index) =>
              _pageViewItem(index, context),
        ),
      );

  Widget _pageViewItem(final int index, final BuildContext context) =>
      GestureDetector(
        onTap: () => onTap.call(
          news[index].newsId,
        ),
        child: Card(
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              _backgroundPicture(index),
              _cardContent(context, index),
            ],
          ),
        ),
      );

  Widget _pageIndicators() => SmoothPageIndicator(
        count: news.length,
        effect: WormEffect(
            dotColor: CustomMilkyTheme.primaryColor.shade300,
            activeDotColor: CustomMilkyTheme.primaryColor,
            dotHeight: Utils.smallSpace,
            dotWidth: Utils.smallSpace,
            spacing: Utils.tinySpace),
        controller: pageController,
      );

  Widget _cardContent(final BuildContext context, final int index) =>
      DecoratedBox(
        decoration: _contentDecoration(),
        child: Padding(
          padding: Utils.mediumPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _logo(),
              Utils.largeVerticalSpacer,
              _title(context, index),
            ],
          ),
        ),
      );

  Widget _title(final BuildContext context, final int index) => Text(
        news[index].title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: CustomMilkyTheme.liteTextColor,
            ),
      );

  Widget _logo() => SetiaLogo(
        color: CustomMilkyTheme.primaryLogoColor,
        size: 70,
      );

  BoxDecoration _contentDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
        color: CustomMilkyTheme.secondaryColor,
        gradient: _gradiant(),
      );

  Gradient _gradiant() => LinearGradient(
        colors: [
          CustomMilkyTheme.primaryColor.shade800.withOpacity(0.7),
          Colors.transparent,
        ],
        stops: const [0.2, 8],
        begin: AlignmentDirectional.topStart,
        end: AlignmentDirectional.bottomEnd,
      );

  Widget _backgroundPicture(final int index) => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            CustomMilkyTheme.borderRadiusSemiRound,
          ),
          color: CustomMilkyTheme.secondaryColor,
          image: DecorationImage(
            image: NetworkImage(
              RepositoryUrls.downloadDocumentUrl(news[index].imageId),
            ),
            fit: BoxFit.cover,
          ),
        ),
      );
}
