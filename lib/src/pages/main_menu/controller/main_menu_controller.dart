import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../setia_module.dart';
import '../../../infrastructures/commons/storage_keys.dart';
import '../../../infrastructures/role_management/custom_access_keys.dart';
import '../../../infrastructures/role_management/setiya_user_access.dart';
import '../../../infrastructures/utils/token/token_info.dart';
import '../../shared/models/enums/page_state_enum.dart';
import '../models/news_preview_view_model.dart';
import '../repository/main_menu_repository.dart';

class MainMenuController extends GetxController {
  final newsPageController = PageController();
  final _repository = MainMenuRepository();

  final Rx<PageStateEnum> state = PageStateEnum.loading.obs;

  final List<NewsPreviewViewModel> news = [];

  final RxBool hasAuthorizeRequest = true.obs;

  @override
  void onInit() async {
    await getLastNews();
    super.onInit();
  }

  Future<void> getLastNews() async {
    state.value = PageStateEnum.loading;
    final resultOrException = await _repository.getLastNews();

    resultOrException.fold(
      (final exception) => state.value = PageStateEnum.retry,
      (final result) {
        news.addAll(result);
        if (SetiaUserAccess.hasUserAccess(
          SetiaCustomAccessKeys.authorizeRequestReminderInMainMenu,
        )) {
          _getAuthorizeRequestStatus();
        } else {
          state.value = PageStateEnum.success;
        }
      },
    );
  }

  Future<void> _getAuthorizeRequestStatus() async {
    final resultOrException = await _repository.getAuthorizeRequestStatus();

    resultOrException.fold(
      (final exception) => state.value = PageStateEnum.retry,
      (final result) {
        hasAuthorizeRequest.value = result.hasRequest;
        state.value = PageStateEnum.success;
      },
    );
  }

  Future<void> onRefresh() async {
    news.clear();
    await getLastNews();
  }

  void onNewsPageViewItemTap(final int newsId) {
    Get.toNamed(SetiaModuleRouteNames.newsPreview, parameters: {
      'newsId': newsId.toString(),
    });
  }

  void onContactUsTap() => Get.toNamed(
        SetiaModuleRouteNames.contactUs,
      );

  void onLogoutTap() {
    final GetStorage storage = GetStorage();
    storage.remove(StorageKeys.loginProperties);
    storage.remove(StorageKeys.userId);
    TokenInfo.clearToken();
    Get.offAllNamed(SetiaModuleRouteNames.splash);
  }

  void onManagementButtonTap() => Get.toNamed(
        SetiaModuleRouteNames.management,
      );

  void onManageChildrenTap() => Get.toNamed(
        SetiaModuleRouteNames.childrenList,
      );

  void onEventSurveyButtonTap() => Get.toNamed(
        SetiaModuleRouteNames.membersEventSurveyList,
      );

  void onProfileButtonTap() => Get.toNamed(
        SetiaModuleRouteNames.publicProfile,
      );

  void onNewsButtonTap() => Get.toNamed(
        SetiaModuleRouteNames.newsList,
      );

  void onQrcodeButtonTap() => Get.toNamed(
        SetiaModuleRouteNames.qrcode,
      );

  void onEventsButtonTap() =>
      Get.toNamed(SetiaModuleRouteNames.membersEventsList);

  Future<void> onAuthorizeButtonTap() async {
    final result = await Get.toNamed(
      SetiaModuleRouteNames.addMembershipRequest,
    );

    if (result != null) {
      hasAuthorizeRequest.value = result as bool;
    }
  }
}
