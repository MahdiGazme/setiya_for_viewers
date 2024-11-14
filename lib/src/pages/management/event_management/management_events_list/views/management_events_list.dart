import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/models/enums/page_state_enum.dart';
import '../../../../shared/view/widgets/page_state.dart';
import '../../../../shared/view/widgets/scaffold_body_container.dart';
import '../../../../shared/view/widgets/search_text_field.dart';
import '../../../../shared/view/widgets/secondary_app_bar.dart';
import '../../../../shared/view/widgets/setia_fab.dart';
import '../../../../shared/view/widgets/setiya_tap_bar.dart';
import '../controller/management_events_list_controller.dart';
import 'widget/management_events_list.dart';

class ManagementEventsList extends GetView<ManagementEventsListController> {
  const ManagementEventsList({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => DefaultTabController(
        length: 2,
        child: MilkyScaffold(
          appBar: _appBar(context),
          backgroundColor: CustomMilkyTheme.primaryColor,
          body: _body(),
          floatingActionButton: Obx(
            () => controller.state.value == PageStateEnum.success
                ? _newEventFAB()
                : const SizedBox(),
          ),
        ),
      );

  Widget _newEventFAB() => SetiaFAB(
        position: controller.isFABHide.value ? -180 : 0,
        child: _fab(),
      );

  FloatingActionButton _fab() => FloatingActionButton.extended(
        onPressed: controller.onNewEventFABTap,
        label: const Text('رویداد جدید'),
        icon: const Icon(
          Icons.edit_outlined,
        ),
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
        child: ManagementEventsListView(),
      );

  Widget _search() => SearchTextField(
        controller: controller.searchText,
        label: const Text('جست و جو'),
        onChanged: (final searchText) =>
            controller.onSearchTextChanged(searchText),
      );

  SecondaryAppBar _appBar(final BuildContext context) => SecondaryAppBar(
        title: const Text('رویداد ها'),
        preferredSize: const Size(
          0,
          100,
        ),
        bottom: _tabBar(context),
      );

  SetiyaTabBar _tabBar(final BuildContext context) => SetiyaTabBar(
        tabs: const [
          Tab(
            text: 'اجرا شده',
          ),
          Tab(
            text: 'در انتظار',
          ),
        ],
        onTap: controller.changeExecutedQuery,
      );
}
