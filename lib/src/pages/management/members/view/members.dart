import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/models/enums/page_state_enum.dart';
import '../../../shared/view/widgets/page_state.dart';
import '../../../shared/view/widgets/scaffold_body_container.dart';
import '../../../shared/view/widgets/search_text_field.dart';
import '../../../shared/view/widgets/secondary_app_bar.dart';
import '../../../shared/view/widgets/setia_fab.dart';
import '../controller/members_controller.dart';
import 'widgets/normal_users_list.dart';

class Members extends GetView<MembersController> {
  const Members({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        backgroundColor: CustomMilkyTheme.primaryColor,
        appBar: const SecondaryAppBar(
          title: Text('مدیریت اعضا'),
        ),
        floatingActionButton: Obx(
          () => controller.pageState.value == PageStateEnum.success
              ? _addUserButton()
              : const SizedBox(),
        ),
        body: ScaffoldBodyContainer(
          child: _state(context),
        ),
      );

  Widget _state(final BuildContext context) => PageStateProvider(
        state: controller.pageState,
        page: _body,
        onRetry: controller.onRetry,
      );

  Widget _body() => Column(
        children: [
          _searchField(),
          Utils.smallVerticalSpacer,
          const Expanded(
            child: NormalUsersList(),
          ),
        ],
      );

  Widget _searchField() => SearchTextField(
        label: const Text('جست و جو'),
        controller: controller.searchText,
        onChanged: controller.onSearchTextChanged,
        prefixIcon: Icons.sort_rounded,
        showPrefix: true,
        onPrefixTap: controller.onFilterTap,
      );

  Widget _addUserButton() => Obx(
        () => SetiaFAB(
          position: controller.isFABHide.value ? -180 : 0,
          child: _fab(),
        ),
      );

  Widget _fab() => FloatingActionButton.extended(
        onPressed: controller.onFABTap,
        icon: const Icon(Icons.mode_edit_outlined),
        label: const Text('افزودن کاربر'),
      );
}
