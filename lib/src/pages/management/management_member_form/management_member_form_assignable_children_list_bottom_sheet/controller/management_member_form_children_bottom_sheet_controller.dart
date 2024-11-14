import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../../../infrastructures/utils/list_view_handler.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/models/advanced_search_type.dart';
import '../../../../shared/models/advanced_search_view_model.dart';
import '../../../../shared/models/enums/page_state_enum.dart';
import '../../../../shared/models/management_child_view_model.dart';
import '../repository/management_member_form_children_bottom_sheet_repository.dart';

class ManagementMemberFormChildrenBottomSheetController extends GetxController {
  final _repository = ManagementMemberFormChildrenBottomSheetRepository();

  final listHandler = ListViewHandler<ManagementChildViewModel>(
    hasPagination: true,
    limit: Utils.paginationLimit,
  );

  final searchText = TextEditingController();

  final _debouncer = Debouncer(delay: Utils.searchDebouncerDuration);

  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;

  final List<ManagementChildViewModel> oldChildren;

  final children = <ManagementChildViewModel>[].obs;

  String? motherId;

  final String motherIdQueryKey = 'MotherId';

  ManagementMemberFormChildrenBottomSheetController({
    required this.oldChildren,
    this.motherId,
  });

  @override
  void onInit() async {
    children.addAll(
      oldChildren,
    );
    if (motherId != null) {
      hasChildrenQuery();
    }
    state.value = PageStateEnum.loading;
    await getAllAssignableChildren();
    super.onInit();
  }

  void onListItemCheckChanged(
    final ManagementChildViewModel item, {
    required final bool isChecked,
  }) async {
    if (isChecked) {
      children.removeWhere((final element) => element.id == item.id);
    } else {
      children.add(item);
    }
  }

  Future<void> getAllAssignableChildren() async {
    final resultOrException = await _repository.getAllAssignableChildren(
      listHandler.query,
    );

    resultOrException.fold(
      (final exception) {
        if (listHandler.list.isEmpty) {
          state.value = PageStateEnum.retry;
        }
      },
      (final result) {
        listHandler.onSuccess(
          items: result,
        );
        state.value = PageStateEnum.success;
      },
    );
  }

  Future<void> onRetry() async {
    state.value = PageStateEnum.loading;
    await getAllAssignableChildren();
  }

  void onButtonTap() => Get.back(result: children);

  Future<void> onListRefresh() async {
    listHandler.prePair(showLoading: true);
    await getAllAssignableChildren();
  }

  void hasChildrenQuery() {
    listHandler.removeFilter(motherIdQueryKey);
    listHandler.addFilter(
      AdvancedQueryViewModel(
        key: motherIdQueryKey,
        startValue: motherId!,
        type: AdvancedSearchType.contains,
        text: motherId,
        show: false,
      ),
    );
  }

  void onSearchTextChanged(final String searchText) {
    _debouncer.call(
      () async {
        listHandler.removeFilter(Utils.fullNameSearchFilterKey);

        if (searchText.trim().isNotEmpty) {
          listHandler.addFilter(
            AdvancedQueryViewModel(
              key: Utils.fullNameSearchFilterKey,
              startValue: searchText,
              type: AdvancedSearchType.contains,
              text: searchText,
              show: false,
            ),
          );
        }
        listHandler.prePair(showLoading: true);
        await getAllAssignableChildren();
      },
    );
  }
}
