import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/view/widgets/page_state.dart';
import '../../../shared/view/widgets/scaffold_body_container.dart';
import '../../../shared/view/widgets/search_text_field.dart';
import '../../../shared/view/widgets/secondary_app_bar.dart';
import '../controller/children_list_controller.dart';
import 'widget/children_list_view.dart';

class ChildrenList extends GetView<ChildrenListController> {
  const ChildrenList({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        appBar: _appBar(context),
        backgroundColor: CustomMilkyTheme.primaryColor,
        body: _body(),
      );

  Widget _body() => ScaffoldBodyContainer(
        child: PageStateProvider(
          onRetry: controller.onRetry,
          state: controller.state,
          page: _content,
        ),
      );

  Widget _content() => Column(
        children: [
          _search(),
          Utils.smallVerticalSpacer,
          _listView(),
        ],
      );

  Widget _listView() => const Expanded(
        child: ChildrenListView(),
      );

  Widget _search() => SearchTextField(
        controller: controller.searchText,
        label: const Text('جست و جو'),
        onChanged: (final searchText) =>
            controller.onSearchTextChanged(searchText),
      );

  SecondaryAppBar _appBar(final BuildContext context) => const SecondaryAppBar(
        title: Text('فرزندان'),
      );
}
