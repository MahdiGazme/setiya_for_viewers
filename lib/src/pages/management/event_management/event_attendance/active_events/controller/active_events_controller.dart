import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../../../../../setia_module.dart';
import '../../../../../../infrastructures/utils/list_view_handler.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../../../../shared/models/advanced_search_type.dart';
import '../../../../../shared/models/advanced_search_view_model.dart';
import '../../../../../shared/models/enums/page_state_enum.dart';
import '../models/active_events_view_model.dart';
import '../repository/active_events_repository.dart';

class ActiveEventsController extends GetxController {
  final _repository = ActiveEventsRepository();

  final listHandler = ListViewHandler<ActiveEventsListItemViewModel>(
    hasPagination: true,
    limit: Utils.paginationLimit,
  );

  final scrollController = ScrollController();

  final searchText = TextEditingController();

  final _debouncer = Debouncer(delay: Utils.searchDebouncerDuration);

  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;

  @override
  void onInit() async {
    state.value = PageStateEnum.loading;
    await getEventsList();
    super.onInit();
  }

  void onListItemTap(final int id) =>
      Get.toNamed(SetiaModuleRouteNames.submitEventAttendance, parameters: {
        'eventId': id.toString(),
      });

  Future<void> getEventsList() async {
    final resultOrException = await _repository.getAllActiveEvents(
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
    await getEventsList();
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
      listHandler.prePair(showLoading: true);
      await getEventsList();
    });
  }
}
