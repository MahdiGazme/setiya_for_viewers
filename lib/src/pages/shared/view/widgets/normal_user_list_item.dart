import 'package:flutter/material.dart';

import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../models/members_list_item_view_model.dart';
import 'setia_avatar_selector/views/setia_avatar_selector.dart';

class NormalUserListItem extends StatelessWidget {
  final MembersListItemViewModel user;
  final void Function() onTap;

  const NormalUserListItem({
    required this.user,
    required this.onTap,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => Card(
        child: _content(context),
      );

  InkWell _content(final BuildContext context) => InkWell(
        onTap:onTap,
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
            _fullName(context),
            Utils.tinyVerticalSpacer,
            _memberShipCode(context),
          ],
        ),
      );

  Widget _fullName(final BuildContext context) => Text(
        '${user.firstName} ${user.lastName}',
        style: Theme.of(context).textTheme.bodyLarge,
      );

  Widget _memberShipCode(final BuildContext context) => Text(
        'کد عضویت: ${user.membershipCode ?? 'ثبت نشده'}',
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: CustomMilkyTheme.textColor.withOpacity(
                0.7,
              ),
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
