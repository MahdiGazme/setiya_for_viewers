import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/date_and_time_utils.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/view/widgets/asset_icon.dart';
import '../../../shared/view/widgets/page_state.dart';
import '../../../shared/view/widgets/scaffold_body_container.dart';
import '../../../shared/view/widgets/secondary_app_bar.dart';
import '../controller/news_preview_controller.dart';
import 'widgets/news_images_page_view.dart';

class NewsPreview extends GetView<NewsPreviewController> {
  const NewsPreview({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        backgroundColor: CustomMilkyTheme.primaryColor,
        appBar: const SecondaryAppBar(
          title: Text('خبر'),
        ),
        body: _body(context),
      );

  Widget _body(final BuildContext context) => ScaffoldBodyContainer(
        child: PageStateProvider(
          state: controller.state,
          page: () => _content(context),
          onRetry: () => controller.getNewsDetails(
            controller.newsId,
          ),
        ),
      );

  Widget _content(final BuildContext context) => SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: Utils.smallPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _images(),
                Utils.mediumVerticalSpacer,
                _title(context),
                Utils.smallVerticalSpacer,
                _newsContent(),
                Utils.smallVerticalSpacer,
                _releaseDate()
              ],
            ),
          ),
        ),
      );

  Widget _releaseDate() => Row(
        children: [
          const AssetIcon(
            path: 'lib/assets/menu_icons/calendar.png',
            size: 23,
          ),
          Utils.tinyHorizontalSpacer,
          Text('تاریخ انتشار: ${DateAndTimeUtils.standardIranDateFormat(
            controller.news!.releaseDate,
          )}'),
        ],
      );

  Widget _newsContent() => DecoratedBox(
        decoration: _newsContentDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  controller.news!.content,
                ),
              ),
            ],
          ),
        ),
      );

  BoxDecoration _newsContentDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
        color: CustomMilkyTheme.primaryColor.shade300,
      );

  Widget _title(final BuildContext context) => Text(
        controller.news!.title,
        style: Theme.of(context).textTheme.titleMedium,
      );

  Widget _images() => NewsImagesPageView(
        imageIds: controller.news!.imageIds,
        controller: PageController(),
      );
}
