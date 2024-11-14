import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../../infrastructures/routes/setia_module_route_names.dart';
import '../../../../../infrastructures/utils/list_view_handler.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/models/advanced_search_type.dart';
import '../../../../shared/models/advanced_search_view_model.dart';
import '../../../../shared/models/enums/page_state_enum.dart';
import '../model/members_event_survey_list_view_model.dart';
import '../repository/members_event_survey_list_repository.dart';

class MembersEventSurveyListController extends GetxController {
  final _repository = MembersEventsSurveyListRepository();

  final listHandler = ListViewHandler<MembersEventSurveyListViewModel>(
    hasPagination: true,
    limit: Utils.paginationLimit,
  );

  final searchText = TextEditingController();

  final _debouncer = Debouncer(delay: Utils.searchDebouncerDuration);

  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;

  @override
  void onInit() async {
    state.value = PageStateEnum.loading;
    await getAvailableEventsList();
    super.onInit();
  }

  void onListItemTap(
    final int id,
  ) async {
    final result = await Get.toNamed(
      SetiaModuleRouteNames.membersEventSurveyForm,
      parameters: {'eventId' : id.toString()},
    );

    if(result != null && (result as bool)) {
      await onListRefresh();
    }
  }

  Future<void> onRetry() async {
    state.value = PageStateEnum.loading;
    await getAvailableEventsList();
  }

  Future<void> getAvailableEventsList() async {
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
    await getAvailableEventsList();
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
        await getAvailableEventsList();
      },
    );
  }

  Duration calculateRemainingTime(final Jalali endTime) {
    final surveyEndTime = endTime.addDays(2).toDateTime();

    return surveyEndTime.difference(DateTime.now());
  }
}
