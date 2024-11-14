import 'package:flutter/material.dart';

import '../../../../infrastructures/themes/custom_milky_theme.dart';

class SetiyaPopupMenu<T> extends StatelessWidget {
  final List<PopupMenuItem<T>> items;
  final void Function(T value) onSelected;

  const SetiyaPopupMenu({
    required this.items,
    required this.onSelected,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Theme(
        // because material design 3 does not support pop up menu elevation
        // at this time.
        data: Theme.of(context).copyWith(useMaterial3: false),
        child: PopupMenuButton(
          color: CustomMilkyTheme.primaryColor.shade50,
          icon: _menuIcon(),
          elevation: 5,
          position: PopupMenuPosition.under,
          shape: _menuShape(),
          constraints: const BoxConstraints(
            minWidth: 150,
          ),
          onSelected: onSelected,
          itemBuilder: (final context) => items,
          splashRadius: 10,
          padding: EdgeInsets.zero,
        ),
      );

  Widget _menuIcon() => Icon(
        Icons.more_vert_rounded,
        color: CustomMilkyTheme.accentColor,
      );

  RoundedRectangleBorder _menuShape() => const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      );
}
