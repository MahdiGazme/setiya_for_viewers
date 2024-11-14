import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../../../setia_module.dart';
import '../../../../infrastructures/utils/list_view_handler.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/models/advanced_search_type.dart';
import '../../../shared/models/advanced_search_view_model.dart';
import '../../../shared/models/enums/page_state_enum.dart';
import '../../../shared/models/members_list_item_view_model.dart';
import '../repository/members_repository.dart';
import '../view/dialog/role_filter_dialog.dart';

class MembersController extends GetxController {
  final Rx<PageStateEnum> pageState = PageStateEnum.loading.obs;

  final listViewHandler = ListViewHandler<MembersListItemViewModel>(
    hasPagination: true,
    limit: Utils.paginationLimit,
  );

  final List<String> roleFilters = <String>[].obs;

  final isFABHide = false.obs;

  final scrollController = ScrollController();

  final searchText = TextEditingController();

  final _searchDebouncer = Debouncer(delay: Utils.searchDebouncerDuration);

  final _filterDebouncer = Debouncer(delay: Utils.filterDebouncerDuration);

  final _repository = MembersRepository();

  @override
  void onInit() async {
    pageState.value = PageStateEnum.loading;
    _hideFAB();
    await getAllNormalUsers();
    super.onInit();
  }

  Future<void> getAllNormalUsers() async {
    final resultOrException = await _repository.getAllNormalUsers(
      query: listViewHandler.query,
    );

    resultOrException.fold(
      (final exception) {
        if (listViewHandler.list.isEmpty) {
          pageState.value = PageStateEnum.retry;
        }
      },
      (final result) {
        listViewHandler.onSuccess(
          items: result,
        );
        pageState.value = PageStateEnum.success;
      },
    );
  }

  Future<void> onListRefresh() async {
    listViewHandler.prePair(showLoading: true);
    await getAllNormalUsers();
  }

  Future<void> onRetry() async {
    pageState.value = PageStateEnum.loading;
    await getAllNormalUsers();
  }

  Future<void> onFilterTap() async {
    final result = await Get.dialog(
      const RoleFilterDialog(),
    );

    if (result != null) {}
  }

  void onFilterChecked(
    final String filter, {
    required final bool isChecked,
  }) {
    if (isChecked) {
      roleFilters.add(filter);
    } else {
      roleFilters.remove(
        filter,
      );
    }

    _onFilterChanged();
  }

  void _onFilterChanged() {
    _filterDebouncer.call(() async {
      if (roleFilters.isEmpty) {
        listViewHandler.removeAllFilters();
      } else {
        final filters = roleFilters
            .map((final element) => AdvancedQueryViewModel(
                  key: 'Roles',
                  startValue: element,
                  type: AdvancedSearchType.contains,
                  text: element,
                  show: false,
                ))
            .toList();

        listViewHandler.addFilters(filters);
      }

      listViewHandler.prePair(showLoading: true);
      await getAllNormalUsers();
    });
  }

  void onFilterClear() async {
    listViewHandler.removeAllFilters();
    roleFilters.clear();
    listViewHandler.prePair(showLoading: true);
    Get.back();
    await getAllNormalUsers();
  }

  void onSearchTextChanged(final String searchText) {
    _searchDebouncer.call(() async {
      listViewHandler.removeFilter(Utils.fullNameSearchFilterKey);

      if (searchText.trim().isNotEmpty) {
        listViewHandler.addFilter(
          AdvancedQueryViewModel(
            key: Utils.fullNameSearchFilterKey,
            startValue: searchText,
            type: AdvancedSearchType.contains,
            text: searchText,
            show: false,
          ),
        );
      }
      listViewHandler.prePair(showLoading: true);
      await getAllNormalUsers();
    });
  }

  void onUserItemTap(final String userId) async {
    final result = await Get.toNamed(
        SetiaModuleRouteNames.managementUserProfile,
        parameters: {'userId': userId});
    if (result != null && result) {
      pageState.value = PageStateEnum.loading;
      await onListRefresh();
    }
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

  void onFABTap() async {
    final result = await Get.toNamed(SetiaModuleRouteNames.addUser);
    if (result != null && result) {
      pageState.value = PageStateEnum.loading;
      await onListRefresh();
    }
  }
}
