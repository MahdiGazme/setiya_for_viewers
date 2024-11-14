import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../../../../setia_module.dart';
import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../infrastructures/utils/list_view_handler.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/models/advanced_search_type.dart';
import '../../../../shared/models/advanced_search_view_model.dart';
import '../../../../shared/models/enums/page_state_enum.dart';
import '../../../../shared/view/dialogs/delete_dialog.dart';
import '../../add_members_to_event_bottom_sheet/controller/add_member_to_event_bottom_sheet_controller.dart';
import '../../add_members_to_event_bottom_sheet/view/add_member_to_event_bottom_sheet.dart';
import '../models/manage_event_participants_view_model.dart';
import '../repository/manage_event_participants_repository.dart';
import '../view/dialogs/confirm_member_request_for_event_dialog.dart';

class ManageEventParticipantsController extends GetxController {
  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;

  final listHandler = ListViewHandler<ManageEventParticipantViewModel>(
    hasPagination: true,
    limit: Utils.paginationLimit,
  );

  RxBool isLoading = false.obs;

  late String eventId;

  final isFABHide = false.obs;

  final scrollController = ScrollController();

  final searchText = TextEditingController();

  final _debouncer = Debouncer(delay: Utils.searchDebouncerDuration);

  final _repository = ManageEventParticipantsRepository();

  final _isRegisteredKey = 'IsRegistered';

  @override
  void onInit() async {
    eventId = Get.parameters['eventId'] as String;
    _hideFAB();
    _setInitialQuery();
    state.value = PageStateEnum.loading;
    await getAllEventParticipants();
    super.onInit();
  }

  void _setInitialQuery() {
    listHandler.addFilter(
      AdvancedQueryViewModel(
        key: _isRegisteredKey,
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
        key: _isRegisteredKey,
        startValue: (index == 0).toString(),
        type: AdvancedSearchType.contains,
        text: (index == 0).toString(),
        show: false,
      ),
    );

    listHandler.prePair(showLoading: true);
    await getAllEventParticipants();
  }

  Future<void> addParticipantToEvent(final String memberId) async {
    isLoading.value = true;
    final resultOrException = await _repository.addMemberToEvent(
      eventId,
      memberId,
    );

    resultOrException.fold(
      (final exception) => isLoading.value = false,
      (final result) async {
        Get.back();
        isLoading.value = false;
        await onListRefresh();
      },
    );
  }

  Future<void> removeParticipantFromEvent(final String memberId) async {
    isLoading.value = true;
    final resultOrException = await _repository.deleteMemberFromEvent(
      eventId,
      memberId,
    );

    resultOrException.fold(
      (final exception) => isLoading.value = false,
      (final result) async {
        Get.back();
        isLoading.value = false;
        await onListRefresh();
      },
    );
  }

  Future<void> acceptMemberRequest(final String memberId) async {
    isLoading.value = true;
    final resultOrException = await _repository.acceptMemberRequest(
      eventId,
      memberId,
    );

    resultOrException.fold(
      (final exception) => isLoading.value = false,
      (final result) async {
        Get.back();
        isLoading.value = false;
        await onListRefresh();
      },
    );
  }

  void onEventParticipantTap(
    final ManageEventParticipantViewModel item,
  ) {
    if (item.hasAccepted) {
      Get.toNamed(
        SetiaModuleRouteNames.managementUserProfile,
        parameters: {
          'userId': item.id,
        },
      );
    } else {
      Get.dialog(
        ConfirmMemberRequestForEventDialog(
          item: item,
          onTap: () => acceptMemberRequest(item.id),
          showLoading: isLoading,
        ),
      );
    }
  }

  void onEventParticipantLongTap(
    final String memberId, {
    required final bool hasAccepted,
  }) {
    if (hasAccepted) {
      Get.dialog(
        DeleteDialog(
          onDeleteButtonTap: () => removeParticipantFromEvent(
            memberId,
          ),
          bodyMessage: 'آیا از حذف این عضو از رویداد اطمینان دارید',
          isLoading: isLoading,
        ),
      );
    }
  }

  void onFabTap() async {
    await Get.bottomSheet(
      settings: RouteSettings(
        arguments: eventId,
      ),
      backgroundColor: CustomMilkyTheme.secondaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(CustomMilkyTheme.borderRadiusRound),
        ),
      ),
      persistent: true,
      useRootNavigator: true,
      const AddMemberToEventBottomSheet(
        AddMemberToEventBottomSheetController.new,
      ),
    );
    await onListRefresh();
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
