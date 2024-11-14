import 'package:flutter/material.dart';

import '../../../../../../infrastructures/role_management/setiya_user_access.dart';
import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../models/grid_menu_item_model.dart';

class GridMenuWidget extends StatelessWidget {
  final List<GridMenuItem> items;

  final List<GridMenuItem> userAccessAbleItems = [];

  GridMenuWidget({
    required this.items,
    final Key? key,
  }) : super(key: key) {
    generateAccessAbleItems();
  }

  @override
  Widget build(final BuildContext context) => GridView.builder(
        itemCount: userAccessAbleItems.length,
        itemBuilder: (final context, final index) => _menuItemWidget(
          userAccessAbleItems[index],
        ),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          crossAxisSpacing: Utils.tinySpace,
        ),
      );

  Widget _menuItemWidget(final GridMenuItem item) => InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
        child: Card(
          child: SizedBox(
            child: Padding(
              padding: Utils.smallPadding,
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: item.child,
                    ),
                  ),
                  Utils.smallVerticalSpacer,
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ),
        ),
      );

  void generateAccessAbleItems() {
    for (final item in items) {
      if (item.roleKey == null ||
          SetiaUserAccess.hasUserAccess(item.roleKey!)) {
        userAccessAbleItems.add(item);
      }
    }
  }
}
