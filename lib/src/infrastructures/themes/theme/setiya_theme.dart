import 'package:flutter/material.dart';
import '../../../../setia_module.dart';
import '../../utils/scroll_behavior.dart';

class SetiyaTheme extends StatelessWidget {
  final Widget child;

  const SetiyaTheme({
    required this.child,
    super.key,
  });

  @override
  Widget build(final BuildContext context) => ScrollConfiguration(
        behavior: const MilkyUiScrollBehavior(),
        child: GestureDetector(
          onTap: () {
            final FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: Theme(
            data: MilkyThemeData.getTheme(context),

            child: child,
          ),
        ),
      );
}
