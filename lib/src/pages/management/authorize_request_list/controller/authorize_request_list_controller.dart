import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../../../setia_module.dart';
import '../../../../infrastructures/utils/list_view_handler.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/models/advanced_search_type.dart';
import '../../../shared/models/advanced_search_view_model.dart';
import '../../../shared/models/enums/page_state_enum.dart';
import '../model/authorize_request_list_item_view_model.dart';
import '../repository/authorize_request_list_repository.dart';

class AuthorizeRequestListController extends GetxController {
  final _repository = AuthorizeRequestListRepository();
  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;
  final searchText = TextEditingController();
  final listHandler = ListViewHandler<AuthorizeRequestListItemViewModel>(
    hasPagination: true,
    limit: Utils.paginationLimit,
  );
  final _debouncer = Debouncer(delay: Utils.searchDebouncerDuration);

  @override
  void onInit() async {
    await getAllRequests();
    super.onInit();
  }

  Future<void> getAllRequests() async {
    final resultOrException =
        await _repository.getAllRequests(listHandler.query);

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
    await getAllRequests();
  }

  Future<void> onListRefresh() async {
    listHandler.prePair(showLoading: true);
    await getAllRequests();
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
      await getAllRequests();
    });
  }

  void onListItemTap(final String id) async {
    final result =
        await Get.toNamed(SetiaModuleRouteNames.authorizeRequest, parameters: {
      'requestId': id,
    });

    if (result != null && (result as bool)) {
      await onListRefresh();
    }
  }

}
