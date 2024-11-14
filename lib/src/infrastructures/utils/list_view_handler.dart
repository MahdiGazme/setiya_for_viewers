import 'package:get/get.dart';
import '../../pages/shared/models/advanced_search_type.dart';
import '../../pages/shared/models/advanced_search_view_model.dart';

class ListViewHandler<T> {
  ListViewHandler({
    this.hasPagination = false,
    this.limit = 10,
  });

  int _page = 0;

  final bool hasPagination;
  final int limit;
  final RxBool showError = false.obs,
      hasMoreData = false.obs,
      showLoading = false.obs;

  final RxList<T> list = <T>[].obs;
  final List<AdvancedQueryViewModel> filterItems = [];

  ///Call this method before request from server.
  void prePair({required final bool showLoading}) {
    _page = 0;
    this.showLoading.value = showLoading;
    hasMoreData.value = false;
    showError.value = false;
    list.clear();
  }

  ///Call this method after getting error response from server.
  void onError() => showError.value = true;

  ///Call this method after getting success response from server.
  void onSuccess({
    required final List<T> items,
  }) {
    _addItems(
      items,
    );
    if (hasPagination) {
      _page++;
    }
    hasMoreData.value = hasPagination && items.length >= limit;
    print(hasMoreData.value);
    showError.value = false;
    showLoading.value = false;
  }

  Future<void> loadMoreData(
    final Future<void> Function() request,
  ) async {
    await request.call();
  }

  void _addItems(final List<T> items) {
    list.addAll(items);
  }

  void addItem(
    final T item, {
    final int? atIndex,
  }) {
    list.insert(atIndex ?? list.length, item);
  }

  void removeAt(final int index) {
    list.removeAt(index);
  }

  void removeWhere(final bool Function(T element) test) {
    list.removeWhere(test);
  }

  void clearItems() {
    list.clear();
  }

  void editItem({
    required final T item,
    required final int index,
  }) {
    list[index] = item;
  }

  void addFilter(final AdvancedQueryViewModel filter) {
    removeFilter(filter.key);
    filterItems.add(filter);
  }

  void addFilters(final List<AdvancedQueryViewModel> filters) {
    removeFilters(filters.map((final e) => e.key).toList());
    filterItems.addAll(filters);
  }

  void removeFilter(final String key) =>
      filterItems.removeWhere((final element) => element.key == key);

  void removeFilters(final List<String> keys) =>
      filterItems.removeWhere((final element) => keys.contains(element.key));

  void removeAllFilters() => filterItems.clear();

  AdvancedQueryViewModel get _offsetFilterChip => AdvancedQueryViewModel(
        type: AdvancedSearchType.offset,
        key: 'offset',
        startValue: _page.toString(),
        show: false,
      );

  AdvancedQueryViewModel get _limitFilterChip => AdvancedQueryViewModel(
        type: AdvancedSearchType.limit,
        key: 'limit',
        startValue: limit.toString(),
        show: false,
      );

  String get query {
    if (hasPagination) {
      removeFilters(['offset', 'limit']);
      filterItems.add(_offsetFilterChip);
      filterItems.add(_limitFilterChip);
    }

    return filterItems.isNotEmpty ? _generateQuery() : '';
  }

  String _generateQuery() {
    final List<String> query = [];

    for (final chip in filterItems) {
      if (chip.type == AdvancedSearchType.range) {
        if (chip.startValue.trim() != '') {
          query.add('start${chip.key}=${chip.startValue}');
        }
        if (chip.endValue != null && chip.endValue!.trim() != '') {
          query.add('end${chip.key}=${chip.endValue}');
        }
      } else {
        query.add('${chip.key}=${chip.startValue}');
      }
    }

    return '?${query.join('&')}';
  }
}
