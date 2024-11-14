import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../../../../setia_module.dart';
import '../../../../../infrastructures/utils/list_view_handler.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/models/advanced_search_type.dart';
import '../../../../shared/models/advanced_search_view_model.dart';
import '../../../../shared/models/enums/page_state_enum.dart';
import '../models/management_event_members_survey_list_view_model.dart';
import '../repository/management_event_members_survey_list_repository.dart';

class ManagementEventMembersSurveyListController extends GetxController {
  final _repository = ManagementEventMembersSurveyListRepository();

  final listHandler =
      ListViewHandler<ManagementEventMembersSurveyListViewModel>(
    hasPagination: true,
    limit: Utils.paginationLimit,
  );

  late String eventId;

  final scrollController = ScrollController();

  final searchText = TextEditingController();

  final _debouncer = Debouncer(delay: Utils.searchDebouncerDuration);

  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;

  RxBool isFABHide = false.obs;

  @override
  void onInit() async {
    eventId = Get.parameters['eventId'] as String;
    state.value = PageStateEnum.loading;
    await getEventCommentsList();
    super.onInit();
  }

  void onListItemTap(
    final int commentId,
  ) =>
      Get.toNamed(SetiaModuleRouteNames.eventMemberCommentDetails, parameters: {
        'commentId': commentId.toString(),
      });

  Future<void> getEventCommentsList() async {
    final resultOrException = await _repository.getAllEventComments(
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
    await getEventCommentsList();
  }

  Future<void> onListRefresh() async {
    listHandler.prePair(showLoading: true);
    await getEventCommentsList();
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
        await getEventCommentsList();
      },
    );
  }

}
