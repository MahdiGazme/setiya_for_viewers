import 'package:flutter/material.dart';

import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/view/widgets/setia_avatar_selector/views/setia_avatar_selector.dart';
import '../../model/authorize_request_list_item_view_model.dart';

class AuthorizeRequestListItem extends StatelessWidget {
  final AuthorizeRequestListItemViewModel user;
  final void Function(String id) onItemTap;

  const AuthorizeRequestListItem({
    required this.user,
    required this.onItemTap,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => Card(
        child: _content(context),
      );

  InkWell _content(final BuildContext context) => InkWell(
        onTap: () => onItemTap.call(user.id),
        child: Padding(
          padding: Utils.smallPadding,
          child: Row(
            children: [
              _avatar(),
              Utils.smallHorizontalSpacer,
              _information(context),
              const Icon(Icons.keyboard_arrow_left)
            ],
          ),
        ),
      );

  Widget _information(final BuildContext context) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${user.firstName} ${user.lastName}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Utils.tinyVerticalSpacer,
            Text(
              '0${user.mobileNumber}',
            )
          ],
        ),
      );

  Widget _avatar() => SetiaAvatarSelector(
        avatarId: user.avatarId,
        memberName: '${user.firstName} ${user.lastName}',
        selectorMode: false,
        borderRadios: CustomMilkyTheme.borderRadiusSemiRound,
        size: 55,
      );
}
