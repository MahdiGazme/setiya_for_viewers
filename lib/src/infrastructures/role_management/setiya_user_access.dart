import '../utils/token/token_info.dart';
import 'setiya_access_map.dart';

mixin SetiaUserAccess {
  static bool hasUserAccess(final String routeName) {
    final routeWithoutParameters = routeName.split('?').first;

    if (!TokenInfo.isLoggedIn) {
      return false;
    }

    if (!SetiyaAccessMap.roleManagementMap
        .containsKey(routeWithoutParameters)) {
      return true;
    }

    final List<String>? pageRoles =
        SetiyaAccessMap.roleManagementMap[routeWithoutParameters];

    bool hasAccess = false;
    for (final role in TokenInfo.roles) {
      if (pageRoles != null && pageRoles.contains(role.value)) {
        hasAccess = true;
      }
    }

    return hasAccess;
  }
}
