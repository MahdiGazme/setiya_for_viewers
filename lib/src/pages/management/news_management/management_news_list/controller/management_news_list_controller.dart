import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../../../../setia_module.dart';
import '../../../../../infrastructures/utils/list_view_handler.dart';
import '../../../../shared/models/enums/page_state_enum.dart';
import '../../../../shared/view/dialogs/delete_dialog.dart';
import '../models/dto/delete_news_dto.dart';
import '../models/management_news_list_item_view_model.dart';
import '../repository/management_news_list_repository.dart';

class ManagementNewsListController extends GetxController {
  final _repository = ManagementNewsListRepository();


  final ScrollController scrollController = ScrollController();

  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;

  final newsListHandler =
      ListViewHandler<ManagementNewsListItemViewModel>(hasPagination: true);

  final isEditingMode = false.obs,
      isDeleteButtonLoading = false.obs,
      isFABHide = false.obs;

  final selectedItems = <int>[].obs;

  @override
  Future<void> onInit() async {
    _hideFAB();
    await getAllNews();
    super.onInit();
  }

  Future<void> getAllNews() async {
    state.value = PageStateEnum.loading;
    final resultOrException = await _repository.getAllNews(
      newsListHandler.query,
    );
    resultOrException.fold(
      (final exception) {
        if (newsListHandler.list.isEmpty) {
          state.value = PageStateEnum.retry;
        }
      },
      (final result) {
        newsListHandler.onSuccess(
          items: result,
        );
        state.value = PageStateEnum.success;
      },
    );
  }

  void onDeleteNewsTap()  {
     Get.dialog(
      DeleteDialog(
        onDeleteButtonTap: _deleteNews,
        bodyMessage:
            'آیا از حذف ${selectedItems.length} خبر انتخاب شده اطمینان دارید؟',
        isLoading: isDeleteButtonLoading,
      ),
    );
  }

  Future<void> onRetry() async {
    state.value = PageStateEnum.loading;
    await getAllNews();
  }

  Future<void> _deleteNews() async {
    isDeleteButtonLoading.value = true;
    final resultOrException = await _repository.deleteNews(
      DeleteNewsDto(newsIds: selectedItems),
    );
    resultOrException.fold(
      (final exception) => isDeleteButtonLoading.value = false,
      (final result) {
        for (int i = 0; selectedItems.length > i; i++) {
          newsListHandler.removeWhere(
              (final element) => element.newsId == selectedItems[i]);
        }
        Get.back();
        exitEditMode();
        isDeleteButtonLoading.value = false;
      },
    );
  }

  Future<void> onListRefresh() async {
    newsListHandler.prePair(showLoading: true);
    await getAllNews();
  }

  void onListItemTap(final int newsId) {
    if (isEditingMode.value) {
      if (!selectedItems.contains(newsId)) {
        selectedItems.add(newsId);
      } else {
        _removeNewsIdFromSelectedList(newsId);
      }
    } else {
      Get.toNamed(SetiaModuleRouteNames.newsPreview, parameters: {
        'newsId': newsId.toString(),
      });
    }
  }

  void exitEditMode() {
    selectedItems.clear();
    isEditingMode.value = false;
  }

  void onEditIconTap() async {
    final result = await Get.toNamed(SetiaModuleRouteNames.editNews,
        parameters: {'newsId': selectedItems.first.toString()});
    exitEditMode();
    if (result != null && result) {
      state.value = PageStateEnum.loading;
      await onListRefresh();
    }
  }

  void onListItemLongPress(final int newsId) {
    if (selectedItems.contains(newsId)) {
      _removeNewsIdFromSelectedList(newsId);
    } else {
      isEditingMode.value = true;
      selectedItems.add(newsId);
    }
  }

  void _removeNewsIdFromSelectedList(final int newsId) {
    selectedItems.remove(newsId);
    if (selectedItems.isEmpty) {
      isEditingMode.value = false;
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

  Future<void> onAddNewsButtonTap() async {
    final result = await Get.toNamed(SetiaModuleRouteNames.addNews);
    if (result != null && result) {
      state.value = PageStateEnum.loading;
      await onListRefresh();
    }
  }

  Future<bool> onWillPop() async {
    if (isEditingMode.value) {
      exitEditMode();
      return false;
    } else {
      return true;
    }
  }
}
