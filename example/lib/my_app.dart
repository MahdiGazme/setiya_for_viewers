import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:setia_module/setia_module.dart';

import 'localization_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => GetMaterialApp(
        title: 'Flutter demo',
        builder: (final context, final child) => SetiyaTheme(child: child!),
        getPages: [
          ...SetiaModuleParameters.pages,
        ],
        initialRoute: SetiaModuleRouteNames.splash,
        debugShowCheckedModeBanner: false,
        locale: const Locale('fa', 'IR'),
        translations: LocalizationService(),
        theme: ThemeData(
          textTheme: MilkyTextStyle.getStyle(context),
        ),
        darkTheme: ThemeData(
          textTheme: MilkyTextStyle.getStyle(context),
        ),
      );
}
