import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/view/dialogs/getx_view.dart';
import '../../../../shared/view/widgets/page_state.dart';
import '../../../../shared/view/widgets/search_text_field.dart';
import '../controller/add_member_to_event_bottom_sheet_controller.dart';
import 'widgets/add_member_to_event_list_view.dart';

class AddMemberToEventBottomSheet
    extends GetxView<AddMemberToEventBottomSheetController> {
  const AddMemberToEventBottomSheet(super.controller, {super.key});

  @override
  Widget build(final BuildContext context) => Padding(
        padding: Utils.mediumPadding,
        child: PageStateProvider(
          state: controller.state,
          onRetry: controller.onRetry,
          page: () => Column(
            children: [
              _searchField(),
              Utils.smallVerticalSpacer,
              const Expanded(
                child: AddMemberToEventListView(),
              ),
            ],
          ),
        ),
      );

  Widget _searchField() => SearchTextField(
        controller: controller.searchText,
        label: Text(
          LocaleKeys.setia_module_shared_commons_search.tr,
        ),
        onChanged: controller.onSearchTextChanged,
      );
}
