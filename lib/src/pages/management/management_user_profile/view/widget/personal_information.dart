import 'package:flutter/material.dart';

import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../infrastructures/utils/date_and_time_utils.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/models/member_view_model.dart';
import '../../../../shared/view/widgets/information_widget.dart';

class PersonalInformation extends StatelessWidget {
  final MemberDetailsViewModel member;

  const PersonalInformation({
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
              'مشخصات فردی',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Utils.largeVerticalSpacer,
            UsersInformationWidget(
              label: 'کد ملی',
              value: member.nationalCode,
            ),
            Utils.mediumVerticalSpacer,
            UsersInformationWidget(
              label: 'تاریخ تولد',
              value:
                  DateAndTimeUtils.dateWithMountNameFormatter(member.birthDate),
            ),
            Utils.mediumVerticalSpacer,
            UsersInformationWidget(
              label: 'وضعیت تاهل',
              value: member.marriageStatus.name,
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
