import 'dart:ui';

import 'package:flutter/material.dart';

class MilkyUiScrollBehavior extends MaterialScrollBehavior {
  const MilkyUiScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.invertedStylus,
  };
}
