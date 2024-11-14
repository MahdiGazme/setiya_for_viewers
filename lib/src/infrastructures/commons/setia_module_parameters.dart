import 'package:get/get.dart';

import '../routes/steia_module_route_pages.dart';

class SetiaModuleParameters {
  SetiaModuleParameters._();

  static late final String baseUrl;
  static late final String fullBaseUrl;
  static final List<GetPage<dynamic>> pages = SetiaModuleRoutePages.routes;
}
