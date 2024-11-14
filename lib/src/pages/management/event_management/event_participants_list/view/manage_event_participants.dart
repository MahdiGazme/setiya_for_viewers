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
import '../controller/manage_event_participants_controller.dart';
import 'widget/manage_event_participants_list_view.dart';

class ManageEventParticipants
    extends GetView<ManageEventParticipantsController> {
  const ManageEventParticipants({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => DefaultTabController(
        length: 2,
        child: MilkyScaffold(
          backgroundColor: CustomMilkyTheme.primaryColor,
          appBar: _appBar(),
          body: _body(),
          floatingActionButton: Obx(
            () => controller.state.value == PageStateEnum.success
                ? _addParticipantFAB(context)
                : const SizedBox(),
          ),
        ),
      );

  SecondaryAppBar _appBar() => SecondaryAppBar(
        title: const Text('شرکت کنندگان'),
        preferredSize: const Size(
          0,
          100,
        ),
        bottom: _tabBar(),
      );

  SetiyaTabBar _tabBar() => SetiyaTabBar(
        tabs: const [
          Tab(
            child: Text('تایید شده'),
          ),
          Tab(
            child: Text('در انتظار تایید'),
          ),
        ],
        onTap: controller.changeExecutedQuery,
      );

  Widget _body() => ScaffoldBodyContainer(
        child: PageStateProvider(
          state: controller.state,
          page: _bodyContent,
          onRetry: controller.onRetry,
        ),
      );

  Widget _bodyContent() => Column(
        children: [
          SearchTextField(
            controller: controller.searchText,
            onChanged: controller.onSearchTextChanged,
            label: const Text('جست و جو'),
          ),
          Utils.smallVerticalSpacer,
          const Expanded(
            child: ManageEventParticipantsListView(),
          ),
        ],
      );

  Widget _addParticipantFAB(final BuildContext context) => SetiaFAB(
        position: controller.isFABHide.value ? -180 : 0,
        child: _fab(context),
      );

  FloatingActionButton _fab(final BuildContext context) =>
      FloatingActionButton.extended(
        onPressed: controller.onFabTap,
        label: const Text('افزودن شرکت کننده'),
        icon: const Icon(
          Icons.edit_outlined,
        ),
      );
}
