import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../setia_module.dart';
import '../../../../infrastructures/role_management/setiya_user_access.dart';

class RouteGourdMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(final String? route) =>
      SetiaUserAccess.hasUserAccess(route!)
          ? null
          : const RouteSettings(
              name: SetiaModuleRouteNames.forbidden,
            );
}
