import 'package:flutter/material.dart';

import '../../../../infrastructures/utils/utils.dart';

class MultiSelectModeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget title;
  final int selectedItemsCount;
  final bool isDisabled;

  final void Function() onDeleteButtonTap;
  final void Function() onEditButtonTap;
  final void Function() onCancelButtonTap;

  const MultiSelectModeAppBar({
    required this.title,
    required this.selectedItemsCount,
    required this.onCancelButtonTap,
    required this.onEditButtonTap,
    required this.onDeleteButtonTap,
    this.isDisabled = false,
    final Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size(0.0, 0.66);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => AppBar(
    title: title,
    centerTitle: false,
    leading: _editModeAppbarLeading(),
    actions: _editModeDeleteAndEditIcons(),
  );

  Widget _editModeAppbarLeading() => IconButton(
        onPressed: onCancelButtonTap,
        icon: const Icon(Icons.close),
      );

  List<Widget> _editModeDeleteAndEditIcons() => [
        Row(
          children: [
            if (selectedItemsCount == 1)
              IconButton(
                onPressed: isDisabled ? null : onEditButtonTap,
                icon: const Icon(
                  Icons.edit,
                ),
              ),
            Utils.tinyHorizontalSpacer,
            IconButton(
              onPressed: isDisabled ? null : onDeleteButtonTap,
              icon: const Icon(
                Icons.delete,
              ),
            )
          ],
        ),
      ];
}
