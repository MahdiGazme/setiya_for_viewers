import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/models/enums/member_event_execution_status_enum.dart';
import '../../../../shared/view/widgets/page_state.dart';
import '../../../../shared/view/widgets/scaffold_body_container.dart';
import '../../../../shared/view/widgets/search_text_field.dart';
import '../../../../shared/view/widgets/secondary_app_bar.dart';
import '../../../../shared/view/widgets/setiya_tap_bar.dart';
import '../controller/members_event_history_list_controller.dart';
import 'widget/member_events_history_list_view.dart';

class MemberEventsHistoryList
    extends GetView<MembersEventsHistoryListController> {
  const MemberEventsHistoryList({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => DefaultTabController(
        length: 5,
        child: MilkyScaffold(
          appBar: _appBar(context),
          backgroundColor: CustomMilkyTheme.primaryColor,
          body: _body(),
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
        child: MemberEventsHistoryListView(),
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
        tabs: [
          Tab(
            text: MemberEventExecutionStatusEnum.registered.name,
          ),
          Tab(
            text: MemberEventExecutionStatusEnum.present.name,
          ),
          Tab(
            text: MemberEventExecutionStatusEnum.canceled.name,
          ),
          Tab(
            text: MemberEventExecutionStatusEnum.absence.name,
          ),
          Tab(
            text: MemberEventExecutionStatusEnum.await.name,
          ),
        ],
        onTap: controller.changeExecutedQuery,
        isScrollable: true,
      );
}
