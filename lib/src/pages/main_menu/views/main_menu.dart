import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../../setia_module.dart';
import '../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../infrastructures/utils/token/token_info.dart';
import '../../../infrastructures/utils/utils.dart';
import '../../shared/view/widgets/asset_icon.dart';
import '../../shared/view/widgets/grid_menu_widget/models/grid_menu_item_model.dart';
import '../../shared/view/widgets/grid_menu_widget/views/grid_menu_widget.dart';
import '../../shared/view/widgets/page_state.dart';
import '../../shared/view/widgets/primary_app_bar.dart';
import '../../shared/view/widgets/scaffold_body_container.dart';
import '../controller/main_menu_controller.dart';
import 'widget/authorize_alert.dart';
import 'widget/login_alert.dart';
import 'widget/news_page_view.dart';

class MainMenu extends GetView<MainMenuController> {
  const MainMenu({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        backgroundColor: CustomMilkyTheme.primaryColor,
        appBar: const PrimaryAppBar(),
        body: ScaffoldBodyContainer(
          child: _body(context),
        ),
      );

  Widget _body(final BuildContext context) => PageStateProvider(
        onRetry: controller.getLastNews,
        page: () => _content(
          context,
        ),
        state: controller.state,
      );

  Widget _content(final BuildContext context) => RefreshIndicator(
        onRefresh: controller.onRefresh,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child: Column(
          children: [
            if (!TokenInfo.isLoggedIn) _loginAlert(),
            if (!controller.hasAuthorizeRequest.value) const AuthorizeAlert(),
            if (controller.news.isNotEmpty) _newsPageView(),
            Utils.mediumVerticalSpacer,
            _menu(),
          ],
        ),
      );

  Widget _loginAlert() => const Column(
        children: [
          LoginAlert(),
          Utils.mediumVerticalSpacer,
        ],
      );

  Widget _menu() => Expanded(
        child: GridMenuWidget(
          items: [
            _newsItem(),
            _managementItem(),
            _childrenManagement(),
            _profile(),
            _events(),
            _survey(),
            _qrcode(),
            _contactUs(),
            if (TokenInfo.isLoggedIn) _logOut(),
          ],
        ),
      );

  GridMenuItem _managementItem() => GridMenuItem(
        onTap: controller.onManagementButtonTap,
        title: LocaleKeys.setia_module_pages_main_menu_management.tr,
        roleKey: SetiaModuleRouteNames.management,
        child: const AssetIcon(
          path: 'lib/assets/menu_icons/management.png',
        ),
      );

  GridMenuItem _childrenManagement() => GridMenuItem(
        onTap: controller.onManageChildrenTap,
        title: LocaleKeys.setia_module_pages_main_menu_my_child.tr,
        roleKey: SetiaModuleRouteNames.childrenList,
        child: const AssetIcon(
          path: 'lib/assets/menu_icons/children.png',
        ),
      );

  GridMenuItem _profile() => GridMenuItem(
        onTap: controller.onProfileButtonTap,
        title: LocaleKeys.setia_module_pages_main_menu_profile.tr,
        roleKey: SetiaModuleRouteNames.publicProfile,
        child: const AssetIcon(
          path: 'lib/assets/menu_icons/profile.png',
        ),
      );

  GridMenuItem _newsItem() => GridMenuItem(
        onTap: controller.onNewsButtonTap,
        title: LocaleKeys.setia_module_pages_main_menu_news.tr,
        child: const AssetIcon(
          path: 'lib/assets/menu_icons/news.png',
        ),
      );

  GridMenuItem _qrcode() => GridMenuItem(
        onTap: controller.onQrcodeButtonTap,
        title: LocaleKeys.setia_module_pages_main_menu_qr_code.tr,
        roleKey: SetiaModuleRouteNames.qrcode,
        child: const AssetIcon(
          path: 'lib/assets/menu_icons/qr_code.png',
        ),
      );

  GridMenuItem _logOut() => GridMenuItem(
        onTap: controller.onLogoutTap,
        title: LocaleKeys.setia_module_pages_main_menu_log_out.tr,
        child: const AssetIcon(
          path: 'lib/assets/menu_icons/logOut.png',
        ),
      );

  GridMenuItem _contactUs() => GridMenuItem(
        roleKey: SetiaModuleRouteNames.contactUs,
        onTap: controller.onContactUsTap,
        title: LocaleKeys.setia_module_pages_main_menu_contact_us.tr,
        child: const AssetIcon(
          path: 'lib/assets/menu_icons/contact_us.png',
        ),
      );

  GridMenuItem _events() => GridMenuItem(
        onTap: controller.onEventsButtonTap,
        title: LocaleKeys.setia_module_pages_main_menu_events.tr,
        roleKey: SetiaModuleRouteNames.membersEventsList,
        child: const AssetIcon(
          path: 'lib/assets/menu_icons/event.png',
        ),
      );

  GridMenuItem _survey() => GridMenuItem(
        onTap: controller.onEventSurveyButtonTap,
        title: LocaleKeys.setia_module_pages_main_menu_event_survey.tr,
        roleKey: SetiaModuleRouteNames.membersEventSurveyList,
        child: const AssetIcon(
          path: 'lib/assets/menu_icons/event_survey.png',
        ),
      );

  Widget _newsPageView() => NewsPageView(
        news: controller.news,
        pageController: controller.newsPageController,
        onTap: controller.onNewsPageViewItemTap,
      );
}
