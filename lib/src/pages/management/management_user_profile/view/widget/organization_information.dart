import 'package:flutter/material.dart';

import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/models/member_view_model.dart';
import '../../../../shared/view/widgets/information_widget.dart';

class OrganizationInformation extends StatelessWidget {
  final MemberDetailsViewModel member;

  const OrganizationInformation({
    required this.member,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => DecoratedBox(
        decoration: _bodyDecoration(),
        child: _bodyItems(context),
      );

  Widget _bodyItems(final BuildContext context) => Padding(
        padding: Utils.smallPadding,
        child: Column(
          children: [
            Text(
              'مشخصات سازمانی',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Utils.largeVerticalSpacer,
            UsersInformationWidget(
              label: 'سطح دسترسی',
              value: member.role.name,
            ),
            Utils.mediumVerticalSpacer,
            UsersInformationWidget(
              label: 'امتیاز',
              value: member.rate.toString(),
            ),
            Utils.mediumVerticalSpacer,
            UsersInformationWidget(
              label: 'کد عضویت',
              value: member.membershipCode != null ? member.membershipCode.toString() : '',
            ),
          ],
        ),
      );

  BoxDecoration _bodyDecoration() => BoxDecoration(
        color: CustomMilkyTheme.primaryColor.shade200,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            CustomMilkyTheme.borderRadiusSemiRound,          ),
        ),
      );
}
