import 'dart:ui';

import 'package:get/get.dart';

import '../../../../infrastructures/themes/custom_milky_theme.dart';

class SetiyaSnackbar {
  void showSnackbar(
    final String title,
    final String message, {
    final SetiyaSnackbarStatus status = SetiyaSnackbarStatus.info,
  }) =>
      Get.snackbar(
        title,
        message,
        backgroundColor: _getColor(status),
      );

  Color _getColor(final SetiyaSnackbarStatus status) {
    switch (status) {
      case SetiyaSnackbarStatus.success:
        return CustomMilkyTheme.successColor.withOpacity(0.5);
      case SetiyaSnackbarStatus.danger:
        return CustomMilkyTheme.dangerColor.withOpacity(0.5);
      case SetiyaSnackbarStatus.warning:
        return CustomMilkyTheme.warningColor.withOpacity(0.5);
      case SetiyaSnackbarStatus.info:
        return CustomMilkyTheme.infoColor.withOpacity(0.5);
    }
  }
}

enum SetiyaSnackbarStatus {
  success,
  danger,
  warning,
  info,
}
