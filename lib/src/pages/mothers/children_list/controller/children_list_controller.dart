import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../../../setia_module.dart';
import '../../../../infrastructures/utils/list_view_handler.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/models/advanced_search_type.dart';
import '../../../shared/models/advanced_search_view_model.dart';
import '../../../shared/models/enums/page_state_enum.dart';
import '../models/children_list_item_view_model.dart';
import '../repository/children_list_repository.dart';

class ChildrenListController extends GetxController {
  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;

  final listHandler = ListViewHandler<ChildrenListItemViewModel>(
    hasPagination: true,
    limit: Utils.paginationLimit,
  );

  final searchText = TextEditingController();

  final _debouncer = Debouncer(delay: Utils.searchDebouncerDuration);

  final _repository = ChildrenListRepository();

  @override
  void onInit() async {
    state.value = PageStateEnum.loading;
    await getAllChildren();
    super.onInit();
  }

  Future<void> getAllChildren() async {
    final resultOrException = await _repository.getAllChildren(
      query: listHandler.query,
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
    await getAllChildren();
  }

  Future<void> onListRefresh() async {
    listHandler.prePair(showLoading: true);
    await getAllChildren();
  }

  void onSearchTextChanged(final String searchText) {
    _debouncer.call(() async {
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
      await getAllChildren();
    });
  }

  void onChildItemTap(final String childId) => Get.toNamed(
        SetiaModuleRouteNames.childrenEventHistoryList,
        parameters: {'childId': childId},
      );

  void simulator() {
    listHandler.onSuccess(
      items: [
        const ChildrenListItemViewModel(
          id: '2417a5f4-6b2b-4341-86d8-ad689b7bf60c',
          firstName: 'فرزند',
          lastName: '3',
          membershipCode: 1102,
        ),
      ],
    );
    state.value = PageStateEnum.success;
  }
}
