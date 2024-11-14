import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../setia_module.dart';
import '../../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../shared/view/widgets/asset_icon.dart';
import '../../../shared/view/widgets/grid_menu_widget/models/grid_menu_item_model.dart';
import '../../../shared/view/widgets/grid_menu_widget/views/grid_menu_widget.dart';
import '../../../shared/view/widgets/scaffold_body_container.dart';
import '../../../shared/view/widgets/secondary_app_bar.dart';
import '../controller/management_controller.dart';

class Management extends GetView<ManagementController> {
  const Management({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        appBar: SecondaryAppBar(
          title: Text(
            LocaleKeys.setia_module_pages_management_menu_title.tr,
          ),
        ),
        backgroundColor: CustomMilkyTheme.primaryColor,
        body: _body(),
      );

  Widget _body() => ScaffoldBodyContainer(
        child: _menu(),
      );

  Widget _menu() => GridMenuWidget(
        items: [
          _newsManagement(),
          _membersManagement(),
          _authorize(),
          _eventsManagement(),
          _scanQrcode(),
          // _membersInformation(),
        ],
      );

  GridMenuItem _newsManagement() => GridMenuItem(
        roleKey: SetiaModuleRouteNames.managementNewsList,
        onTap: controller.onNewsManagementTap,
        title: LocaleKeys.setia_module_pages_management_menu_news_management.tr,
        child: const AssetIcon(
          path: 'lib/assets/menu_icons/news.png',
        ),
      );

  GridMenuItem _authorize() => GridMenuItem(
        roleKey: SetiaModuleRouteNames.authorizeRequestList,
        onTap: controller.onAuthorizeTap,
        title: LocaleKeys.setia_module_pages_management_menu_authorize.tr,
        child: const AssetIcon(
          path: 'lib/assets/menu_icons/authorize.png',
        ),
      );

  GridMenuItem _scanQrcode() => GridMenuItem(
        roleKey: SetiaModuleRouteNames.submitEventAttendance,
        onTap: controller.onScanQrcodeButtonTap,
        title: LocaleKeys
            .setia_module_pages_management_menu_registration_entrance.tr,
        child: const AssetIcon(
          path: 'lib/assets/menu_icons/qr_code.png',
        ),
      );

  GridMenuItem _eventsManagement() => GridMenuItem(
        roleKey: SetiaModuleRouteNames.managementEventsList,
        onTap: controller.onEventsManagementTap,
        title:
            LocaleKeys.setia_module_pages_management_menu_events_management.tr,
        child: const AssetIcon(
          path: 'lib/assets/menu_icons/event.png',
        ),
      );

  GridMenuItem _membersManagement() => GridMenuItem(
        roleKey: SetiaModuleRouteNames.members,
        onTap: controller.onMembersManagementTap,
        title:
            LocaleKeys.setia_module_pages_management_menu_members_management.tr,
        child: const AssetIcon(
          path: 'lib/assets/menu_icons/memberManagement.png',
        ),
      );
}
