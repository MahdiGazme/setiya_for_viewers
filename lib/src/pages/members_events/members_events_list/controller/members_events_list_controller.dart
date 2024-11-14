import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../../../setia_module.dart';
import '../../../../infrastructures/utils/list_view_handler.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/models/advanced_search_type.dart';
import '../../../shared/models/advanced_search_view_model.dart';
import '../../../shared/models/enums/page_state_enum.dart';
import '../../../shared/models/members_event_list_item_view_model.dart';
import '../repository/members_events_list_repository.dart';

class MembersEventsListController extends GetxController {
  final _repository = MembersEventsListRepository();

  final listHandler = ListViewHandler<MembersEventListViewModel>(
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

  void onListItemTap(final int id) async {
    final result = await Get.toNamed(
      SetiaModuleRouteNames.membersEventDetails,
      parameters: {
        'eventId': id.toString(),
      },
    );

    if (result != null && result as bool) {
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
      listHandler.prePair(showLoading: true);
      await getEventsList();
    });
  }
}
