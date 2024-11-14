import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../../../../setia_module.dart';
import '../../../../infrastructures/utils/list_view_handler.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/models/advanced_search_type.dart';
import '../../../shared/models/advanced_search_view_model.dart';
import '../../../shared/models/enums/member_event_execution_status_enum.dart';
import '../../../shared/models/enums/page_state_enum.dart';
import '../../../shared/models/members_event_list_item_view_model.dart';
import '../repository/children_event_history_list_repository.dart';

class ChildrenEventHistoryListController extends GetxController {
  final _repository = ChildrenEventHistoryListRepository();

  final listHandler = ListViewHandler<MembersEventListViewModel>(
    hasPagination: true,
    limit: Utils.paginationLimit,
  );

  final scrollController = ScrollController();

  final searchText = TextEditingController();

  final _debouncer = Debouncer(
    delay: Utils.searchDebouncerDuration,
  );

  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;

  final _executionStatusQuarryKey = 'Status';

  RxBool isFABHide = false.obs;

  late String childId;

  @override
  void onInit() async {
    childId = Get.parameters['childId'] as String;
    state.value = PageStateEnum.loading;
    _setInitialQuery();
    await getEventsList();
    super.onInit();
  }

  void _setInitialQuery() {
    listHandler.addFilter(
      AdvancedQueryViewModel(
        key: _executionStatusQuarryKey,
        startValue: MemberEventExecutionStatusEnum.registered.value.toString(),
        type: AdvancedSearchType.contains,
        text: 'true',
        show: false,
      ),
    );
  }

  Future<void> onRetry() async {
    state.value = PageStateEnum.loading;
    await getEventsList();
  }

  void onListItemTap(
    final int id,
  ) {
    Get.toNamed(
      SetiaModuleRouteNames.childrenEventHistoryDetails,
      parameters: {
        'eventId': id.toString(),
        'childId': childId,
      },
    );
  }

  Future<void> getEventsList() async {
    final resultOrException = await _repository.getAllEvents(
      childId,
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
        key: _executionStatusQuarryKey,
        startValue:
            MemberEventExecutionStatusEnum.fromIndex(index).value.toString(),
        type: AdvancedSearchType.contains,
        text: (index == 0).toString(),
        show: false,
      ),
    );

    listHandler.prePair(showLoading: true);
    await getEventsList();
  }
}