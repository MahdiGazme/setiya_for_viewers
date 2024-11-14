import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../widgets/asset_icon.dart';
import 'setiya_alert_dialog.dart';

class DeleteDialog extends StatelessWidget {
  final void Function() onDeleteButtonTap;
  final String bodyMessage;
  final RxBool isLoading;

  const DeleteDialog({
    required this.onDeleteButtonTap,
    required this.bodyMessage,
    required this.isLoading,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => SetiyaAlertDialog(
        content: _dialogBody(context),
        title: Text(
          'هشدار',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: CustomMilkyTheme.dangerColor,
              ),
        ),
        icon: const Align(
          child: AssetIcon(
            path: 'lib/assets/menu_icons/warning.png',
            size: 50,
          ),
        ),
      );

  Widget _dialogBody(final BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _message(context),
          Utils.largeVerticalSpacer,
          _buttons(context)
        ],
      );

  Widget _buttons(final BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _cancelButton(context),
          Utils.smallHorizontalSpacer,
          _deleteButton(context),
        ],
      );

  Widget _deleteButton(final BuildContext context) => Obx(
        () => OutlinedButton(
          onPressed: isLoading.value ? null : _onDeleteTap,
          child: _deleteButtonChild(),
        ),
      );

  Widget _deleteButtonChild() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('حذف'),
          if (isLoading.value)
            Padding(
              padding: Utils.tinyPadding,
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: CustomMilkyTheme.secondaryColor,
                ),
              ),
            ),
        ],
      );

  FutureOr<void> _onDeleteTap() async {
    onDeleteButtonTap.call();
  }

  Widget _cancelButton(final BuildContext context) => ElevatedButton(
        onPressed: Get.back,
        child: const Text('لغو'),
      );

  Widget _message(final BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: CustomMilkyTheme.primaryColor.shade300,
          borderRadius: BorderRadius.circular(
            CustomMilkyTheme.borderRadiusSemiRound,
          ),
        ),
        child: Align(
          child: Padding(
            padding: Utils.smallPadding,
            child: Text(
              bodyMessage,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
      );

}
