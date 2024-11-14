import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../models/enums/page_state_enum.dart';
import 'loading_indicator.dart';
import 'retry_button.dart';

class PageStateProvider extends StatelessWidget {
  const PageStateProvider({
    required this.state,
    required this.page,
    required this.onRetry,
    final Key? key,
  }) : super(key: key);

  final Rx<PageStateEnum> state;
  final Widget Function() page;
  final void Function() onRetry;

  @override
  Widget build(final BuildContext context) =>
      Obx(
        () => state.value == PageStateEnum.loading
            ? const PageLoadingIndicator()
            : state.value == PageStateEnum.retry
                ? RetryButton(onTap: onRetry.call)
                : page.call(),
      );
}
