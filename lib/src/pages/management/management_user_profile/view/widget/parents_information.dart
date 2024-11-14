import 'package:flutter/material.dart';

import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/models/member_view_model.dart';
import '../../../../shared/view/widgets/information_widget.dart';

class ParentsInformation extends StatelessWidget {
  final MemberDetailsViewModel member;

  const ParentsInformation({
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
              'مشخصات والدین',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Utils.mediumVerticalSpacer,
            UsersInformationWidget(
              label: 'نام پدر',
              value: member.fatherName,
            ),
            Utils.mediumVerticalSpacer,
            UsersInformationWidget(
              label: 'شغل پدر',
              value: member.fatherJob,
            ),
            Utils.mediumVerticalSpacer,
            UsersInformationWidget(
              label: 'نام مادر',
              value: member.motherName,
            ),
            Utils.mediumVerticalSpacer,
            UsersInformationWidget(
              label: 'تلفن مادر',
              value: member.motherPhoneNumber,
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
