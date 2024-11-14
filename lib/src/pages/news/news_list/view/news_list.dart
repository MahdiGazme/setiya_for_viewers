import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../shared/view/widgets/page_state.dart';
import '../../../shared/view/widgets/scaffold_body_container.dart';
import '../../../shared/view/widgets/secondary_app_bar.dart';
import '../controller/news_list_controller.dart';
import 'widgets/news_list_view.dart';

class NewsList extends GetView<NewsListController> {
  const NewsList({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        backgroundColor: CustomMilkyTheme.primaryColor,
        appBar: const SecondaryAppBar(
          title: Text('خبرنامه'),
        ),
        body: _body(),
      );

  Widget _body() => ScaffoldBodyContainer(
        child: PageStateProvider(
          state: controller.state,
          page: _content,
          onRetry: controller.onRetry,
        ),
      );

  Widget _content() => const Column(
        children: [
          Expanded(
            child: NewsListView(),
          ),
        ],
      );
}
