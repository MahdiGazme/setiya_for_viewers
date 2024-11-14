import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../../../../setia_module.dart';
import '../../../../../infrastructures/utils/list_view_handler.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/models/advanced_search_type.dart';
import '../../../../shared/models/advanced_search_view_model.dart';
import '../../../../shared/models/enums/page_state_enum.dart';
import '../models/management_events_list_item_view_model.dart';
import '../repository/management_events_list_repository.dart';

class ManagementEventsListController extends GetxController {
  final _repository = ManagementEventsListRepository();

  final listHandler = ListViewHandler<ManagementEventsListViewModel>(
    hasPagination: true,
    limit: Utils.paginationLimit,
  );

  final scrollController = ScrollController();

  final searchText = TextEditingController();

  final _debouncer = Debouncer(delay: Utils.searchDebouncerDuration);

  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;

  final _isExecutedQueryKey = 'DoesExecuted';

  RxBool isFABHide =  false.obs;

  @override
  void onInit() async {
    state.value = PageStateEnum.loading;
    _setInitialQuery();
    _hideFAB();
    await getEventsList();
    super.onInit();
  }

  void _setInitialQuery() {
    listHandler.addFilter(
      AdvancedQueryViewModel(
        key: _isExecutedQueryKey,
        startValue: 'true',
        type: AdvancedSearchType.contains,
        text: 'true',
        show: false,
      ),
    );
  }

  void onNewEventFABTap() async {
    final result = await Get.toNamed(
      SetiaModuleRouteNames.addEvent,
    );
    if (result != null && result as bool) {
      await onListRefresh();
    }
  }

  void onListItemTap(
    final int id,
  ) async {
    final result = await Get.toNamed(
      SetiaModuleRouteNames.managementEventDetails,
      parameters: {
        'eventId': id.toString(),
      },
    );

    if (result != null && (result as bool)) {
      await onListRefresh();
    }
  }

  Future<void> onRetry() async {
    state.value = PageStateEnum.loading;
    await getEventsList();
  }

  Future<void> getEventsList() async {
    final resultOrException = await _repository.getAllEvents(
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

  Future<void> onListRefresh() async {
    listHandler.prePair(showLoading: true);
    await getEventsList();
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
      print(listHandler.query);
      listHandler.prePair(showLoading: true);
      await getEventsList();
    });
  }

  void changeExecutedQuery(final int index) async {
    listHandler.addFilter(
      AdvancedQueryViewModel(
        key: _isExecutedQueryKey,
        startValue: (index == 0).toString(),
        type: AdvancedSearchType.contains,
        text: (index == 0).toString(),
        show: false,
      ),
    );

    listHandler.prePair(showLoading: true);
    await getEventsList();
  }

  void _hideFAB() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isFABHide.value) {
          isFABHide.value = true;
        }
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isFABHide.value) {
          isFABHide.value = false;
        }
      }
    });
  }
}
