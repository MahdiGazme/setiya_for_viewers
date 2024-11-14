import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:setia_module/setia_module.dart';
import 'my_app.dart';

void main() async {
  _initUrl(
    Flavor.stage,
    2,
    'api',
  );

  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  runApp(const MyApp());
}

void _initUrl(
  final Flavor flavor,
  final int version,
  final String suffix,
) {
  final String baseUrl = _getBaseUrl(flavor);
  final String versionPath = version.toString();

  SetiaModuleParameters.baseUrl = baseUrl;
  SetiaModuleParameters.fullBaseUrl = '$baseUrl/$suffix/v$versionPath';
}

String _getBaseUrl(final Flavor flavor) {
  if (flavor == Flavor.prod) {
    return '*********************';
  } else if (flavor == Flavor.stage) {
    return '*********************';
  } else {
    return '*********************';
  }
}

enum Flavor {
  stage,
  prod,
}

