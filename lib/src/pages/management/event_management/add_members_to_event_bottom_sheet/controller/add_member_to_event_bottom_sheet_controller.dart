import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../../../infrastructures/utils/list_view_handler.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/models/advanced_search_type.dart';
import '../../../../shared/models/advanced_search_view_model.dart';
import '../../../../shared/models/enums/page_state_enum.dart';
import '../models/members_list_item_for_add_to_event_view_model.dart';
import '../repository/add_member_to_event_repository.dart';
import '../view/dialog/add_member_to_event_dialog.dart';

class AddMemberToEventBottomSheetController extends GetxController {
  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;

  final listHandler = ListViewHandler<MembersListItemForAddToEventViewModel>(
    hasPagination: true,
    limit: Utils.paginationLimit,
  );

  late String eventId;

  final RxBool showLoading = false.obs;

  final searchText = TextEditingController();

  final _debouncer = Debouncer(delay: Utils.searchDebouncerDuration);

  final _repository = AddMemberToEventRepository();

  @override
  void onInit() async {
    eventId = Get.arguments as String;
    state.value = PageStateEnum.loading;
    await getAllAvailableMembers();
    super.onInit();
  }

  Future<void> getAllAvailableMembers() async {
    final resultOrException = await _repository.getAllAvailableMembers(
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
    await getAllAvailableMembers();
  }

  Future<void> onListRefresh() async {
    listHandler.prePair(showLoading: true);
    await getAllAvailableMembers();
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
      await getAllAvailableMembers();
    });
  }

  void onMemberTap(
    final MembersListItemForAddToEventViewModel item,
  ) async {
    final result = await Get.dialog(
      AddMemberToEventDialog(
        item: item,
        onTap: () => _addMemberToEvent(item.id),
        showLoading: showLoading,
      ),
    );

    if (result != null) {
      await onListRefresh();
    }
  }

  Future<void> _addMemberToEvent(
    final String memberId,
  ) async {
    showLoading.value = true;
    final resultOrException = await _repository.addMemberToEvent(
      eventId,
      memberId,
    );

    resultOrException.fold(
      (final exception) => showLoading.value = false,
      (final result) => Get.back(
        result: true,
      ),
    );
  }
}
