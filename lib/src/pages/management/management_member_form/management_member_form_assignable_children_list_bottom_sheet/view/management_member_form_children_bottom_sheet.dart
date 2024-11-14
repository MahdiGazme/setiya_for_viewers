import 'package:flutter/material.dart';

import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/view/dialogs/getx_view.dart';
import '../../../../shared/view/widgets/page_state.dart';
import '../../../../shared/view/widgets/search_text_field.dart';
import '../controller/management_member_form_children_bottom_sheet_controller.dart';
import 'widget/management_member_form_children_bottom_sheet_list_view.dart';

class ManagementMemberFormChildrenBottomSheet
    extends GetxView<ManagementMemberFormChildrenBottomSheetController> {
  const ManagementMemberFormChildrenBottomSheet(super.controller, {super.key});

  @override
  Widget build(final BuildContext context) => Padding(
        padding: Utils.mediumPadding,
        child: PageStateProvider(
          state: controller.state,
          onRetry: controller.onRetry,
          page: _content,
        ),
      );

  Widget _content() => Column(
          children: [
            _searchField(),
            Utils.smallVerticalSpacer,
            const Expanded(
              child: ManagementMemberFormChildrenBottomSheetListView(),
            ),
            Utils.mediumVerticalSpacer,
            _button()
          ],
        );

  Widget _button() => ElevatedButton(
        onPressed: controller.onButtonTap,
        child: const Text('تایید'),
      );

  Widget _searchField() => SearchTextField(
        controller: controller.searchText,
        label: const Text('جست و جو'),
        onChanged: controller.onSearchTextChanged,
      );
}
