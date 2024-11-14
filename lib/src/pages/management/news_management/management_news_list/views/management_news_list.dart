import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../shared/models/enums/page_state_enum.dart';
import '../../../../shared/view/widgets/list_multiselect_item_app_bar.dart';
import '../../../../shared/view/widgets/page_state.dart';
import '../../../../shared/view/widgets/scaffold_body_container.dart';
import '../../../../shared/view/widgets/secondary_app_bar.dart';
import '../../../../shared/view/widgets/setia_fab.dart';
import '../controller/management_news_list_controller.dart';
import 'widget/management_news_list_view.dart';

class ManagementNewsList extends GetView<ManagementNewsListController> {
  const ManagementNewsList({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        backgroundColor: CustomMilkyTheme.primaryColor,
        appBar: _appBar(),
        body: _body(),
        floatingActionButton: Obx(
          () => controller.state.value == PageStateEnum.success
              ? _addNewsButton()
              : const SizedBox(),
        ),
        onWillPop: controller.onWillPop,
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
            child: ManagementNewsListView(),
          ),
        ],
      );

  PreferredSize _appBar() => PreferredSize(
        preferredSize: Size.copy(
          _normalAppBar().preferredSize,
        ),
        child: Obx(
          () => controller.isEditingMode.value
              ? _editModeAppBar()
              : _normalAppBar(),
        ),
      );

  SecondaryAppBar _normalAppBar() => const SecondaryAppBar(
        title: Text('مدیریت خبرنامه'),
      );

  Widget _editModeAppBar() => MultiSelectModeAppBar(
        title: Text(
          '${controller.selectedItems.length} خبر انتخاب شده',
        ),
        selectedItemsCount: controller.selectedItems.length,
        onCancelButtonTap: controller.exitEditMode,
        onEditButtonTap: controller.onEditIconTap,
        onDeleteButtonTap: controller.onDeleteNewsTap,
        isDisabled: controller.isDeleteButtonLoading.value,
      );

  Widget _addNewsButton() => Obx(
        () => SetiaFAB(
          position: controller.isFABHide.value ? -180 : 0,
          child: _fab(),
        ),
      );

  Widget _fab() => FloatingActionButton.extended(
        onPressed: controller.onAddNewsButtonTap,
        label: const Text('افزودن خبر'),
        icon: const Icon(
          Icons.newspaper_rounded,
        ),
      );
}
