import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../../../../setia_module.dart';
import '../../../../../infrastructures/utils/list_view_handler.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/models/advanced_search_type.dart';
import '../../../../shared/models/advanced_search_view_model.dart';
import '../../../../shared/models/enums/page_state_enum.dart';
import '../models/event_participants_attendance_view_model.dart';
import '../repository/event_participants_attendance_repository.dart';

class EventParticipantAttendanceController extends GetxController {
  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;

  final listHandler = ListViewHandler<EventParticipantsAttendanceViewModel>(
    hasPagination: true,
    limit: Utils.paginationLimit,
  );

  late String eventId;

  final scrollController = ScrollController();

  final searchText = TextEditingController();

  final _debouncer = Debouncer(delay: Utils.searchDebouncerDuration);

  final _repository = EventParticipantsAttendanceRepository();

  final _wasPresentKey = 'WasPresent';

  @override
  void onInit() async {
    eventId = Get.parameters['eventId'] as String;
    _setInitialQuery();
    state.value = PageStateEnum.loading;
    await getAllEventParticipants();
    super.onInit();
  }

  void _setInitialQuery() {
    listHandler.addFilter(
      AdvancedQueryViewModel(
        key: _wasPresentKey,
        startValue: 'true',
        type: AdvancedSearchType.contains,
        text: 'true',
        show: false,
      ),
    );
  }

  Future<void> getAllEventParticipants() async {
    final resultOrException = await _repository.getAllEventParticipants(
      eventId,
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
    await getAllEventParticipants();
  }

  Future<void> onListRefresh() async {
    listHandler.prePair(showLoading: true);
    await getAllEventParticipants();
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
      await getAllEventParticipants();
    });
  }

  void changeExecutedQuery(final int index) async {
    listHandler.addFilter(
      AdvancedQueryViewModel(
        key: _wasPresentKey,
        startValue: (index == 0).toString(),
        type: AdvancedSearchType.contains,
        text: (index == 0).toString(),
        show: false,
      ),
    );

    listHandler.prePair(showLoading: true);
    await getAllEventParticipants();
  }

  void onEventParticipantTap(final String userId) {
    Get.toNamed(
      SetiaModuleRouteNames.managementUserProfile,
      parameters: {'userId' : userId},
    );
  }
}
