import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../../../../shared/view/widgets/page_state.dart';
import '../../../../../shared/view/widgets/scaffold_body_container.dart';
import '../../../../../shared/view/widgets/search_text_field.dart';
import '../../../../../shared/view/widgets/secondary_app_bar.dart';
import '../controller/active_events_controller.dart';
import 'widgets/active_events_list_view.dart';

class ActiveEventsList extends GetView<ActiveEventsController> {
  const ActiveEventsList({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        appBar: _appbar(),
        backgroundColor: CustomMilkyTheme.primaryColor,
        body: _body(),
      );

  Widget _body() => ScaffoldBodyContainer(
        child: PageStateProvider(
          onRetry: controller.onRetry,
          state: controller.state,
          page: _bodyContent,
        ),
      );

  Widget _bodyContent() => Column(
        children: [
          SearchTextField(
            controller: controller.searchText,
            label: const Text('جست و جو'),
            onChanged: controller.onSearchTextChanged,
          ),
          Utils.smallVerticalSpacer,
          const Expanded(
            child: ActiveEventsListview(),
          ),
        ],
      );

  SecondaryAppBar _appbar() => const SecondaryAppBar(
        title: Text(
          'رویداد های فعال',
        ),
      );
}
