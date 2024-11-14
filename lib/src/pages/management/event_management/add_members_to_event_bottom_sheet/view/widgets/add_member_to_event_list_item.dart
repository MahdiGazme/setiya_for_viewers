import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../../../../shared/view/widgets/setia_avatar_selector/views/setia_avatar_selector.dart';
import '../../models/members_list_item_for_add_to_event_view_model.dart';

class AddMemberToEventListItem extends StatelessWidget {
  final MembersListItemForAddToEventViewModel item;
  final void Function() onItemTap;

  const AddMemberToEventListItem({
    required this.item,
    required this.onItemTap,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => Card(
        child: _content(context),
      );

  InkWell _content(final BuildContext context) => InkWell(
        onTap: onItemTap,
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
        '${item.firstName} ${item.lastName}',
        style: Theme.of(context).textTheme.bodyLarge,
      );

  Widget _memberShipCode(final BuildContext context) => Text(
        '${LocaleKeys.setia_module_shared_members_membership_code.tr}: '
        '${item.code ?? LocaleKeys.setia_module_shared_commons_not_registered.tr}',
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: CustomMilkyTheme.textColor.withOpacity(
                0.7,
              ),
            ),
      );

  Widget _avatar() => SetiaAvatarSelector(
        avatarId: item.avatarId,
        memberName: '${item.firstName} ${item.lastName}',
        selectorMode: false,
        borderRadios: CustomMilkyTheme.borderRadiusSemiRound,
        size: 55,
      );
}
