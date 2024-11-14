import 'package:flutter/material.dart';

import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../../../../shared/view/widgets/setia_avatar_selector/views/setia_avatar_selector.dart';
import '../../models/manage_event_participants_view_model.dart';

class ManageEventParticipantsListItem extends StatelessWidget {
  final ManageEventParticipantViewModel item;
  final void Function() onItemTap;

  final void Function(
    String id, {
    required bool hasAccepted,
  }) onItemLongTap;

  const ManageEventParticipantsListItem({
    required this.item,
    required this.onItemTap,
    required this.onItemLongTap,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => Card(
        child: _content(context),
      );

  InkWell _content(final BuildContext context) => InkWell(
        onTap: onItemTap,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
        onLongPress: () => onItemLongTap(
          item.id,
          hasAccepted: item.hasAccepted,
        ),
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
        'کد عضویت: ${item.memberCode ?? 'ثبت نشده'}',
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
