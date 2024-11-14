import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../infrastructures/themes/custom_milky_theme.dart';

const double defaultResponsiveMaxWidth = 600;

/// default constraints in responsive window
const BoxConstraints defaultResponsiveConstraint =
    BoxConstraints(maxWidth: defaultResponsiveMaxWidth);

class MilkyScaffold extends StatelessWidget {
  final Future<bool> Function()? onWillPop;
  final BoxConstraints constraints;
  final String? themeName;
  final Color? backgroundColor;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? body;
  final Widget? footer;
  final bool showFooter;
  final bool showBorder;
  final bool fillParentHeight;
  final bool resizeToAvoidBottomInset;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? padding;
  final Key? scaffoldKey;
  final bool isResponsive;
  final Alignment scaffoldAlignment;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final Widget? bottomSheet;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final String? restorationId;
  final Color? drawerScrimColor;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final DrawerCallback? onEndDrawerChanged;
  final DrawerCallback? onDrawerChanged;
  final List<Widget>? persistentFooterButtons;

  const MilkyScaffold({
    super.key,
    this.scaffoldKey,
    this.drawer,
    this.endDrawer,
    this.body,
    this.appBar,
    this.floatingActionButton,
    this.footer,
    this.showFooter = false,
    this.onWillPop,
    this.resizeToAvoidBottomInset = true,
    this.backgroundColor,
    this.showBorder = true,
    this.contentPadding,
    this.fillParentHeight = true,
    this.floatingActionButtonLocation,
    this.bottomSheet,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.floatingActionButtonAnimator,
    this.restorationId,
    this.onEndDrawerChanged,
    this.onDrawerChanged,
    this.persistentFooterButtons,
    this.padding,
    this.isResponsive = false,
    this.scaffoldAlignment = Alignment.topCenter,
    this.constraints = defaultResponsiveConstraint,
    this.themeName,
  }) : assert(
          !showFooter || footer != null,
          'when showFooter is true footer must not be null',
        );

  @override
  Widget build(final BuildContext context) => WillPopScope(
        onWillPop: onWillPop,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: CustomMilkyTheme.backgroundColor,
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: constraints,
            child: Scaffold(
              backgroundColor: backgroundColor,
              key: scaffoldKey,
              drawer: drawer,
              endDrawer: endDrawer,
              appBar: appBar,
              body: _bodySizeProvider(body ?? const SizedBox()),
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              floatingActionButton: floatingActionButton,
              floatingActionButtonLocation: floatingActionButtonLocation,
              floatingActionButtonAnimator: floatingActionButtonAnimator,
              bottomSheet: bottomSheet,
              drawerEdgeDragWidth: drawerEdgeDragWidth,
              drawerDragStartBehavior: drawerDragStartBehavior,
              drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
              drawerScrimColor: drawerScrimColor,
              endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
              primary: primary,
              restorationId: restorationId,
              extendBody: extendBody,
              extendBodyBehindAppBar: extendBodyBehindAppBar,
              onDrawerChanged: onDrawerChanged,
              onEndDrawerChanged: onEndDrawerChanged,
              persistentFooterButtons: persistentFooterButtons,
            ),
          ),
        ),
      );

  Widget _bodySizeProvider(final Widget body) => LayoutBuilder(
        builder: (final context, final constraints) => Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth:
                  math.min(this.constraints.maxWidth, constraints.maxWidth),
            ),
            child: Padding(
              padding: contentPadding ?? EdgeInsets.zero,
              child: body,
            ),
          ),
        ),
      );
}
