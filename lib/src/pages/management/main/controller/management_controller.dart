import 'package:get/get.dart';

import '../../../../../setia_module.dart';

class ManagementController extends GetxController {


  void onNewsManagementTap() => Get.toNamed(
        SetiaModuleRouteNames.managementNewsList,
      );

  void onMembersManagementTap() => Get.toNamed(SetiaModuleRouteNames.members);

  void onEventsManagementTap() => Get.toNamed(
        SetiaModuleRouteNames.managementEventsList,
      );

  void onAuthorizeTap() => Get.toNamed(
        SetiaModuleRouteNames.authorizeRequestList,
      );

  void onScanQrcodeButtonTap() => Get.toNamed(
        SetiaModuleRouteNames.activeEvents,
      );
}
