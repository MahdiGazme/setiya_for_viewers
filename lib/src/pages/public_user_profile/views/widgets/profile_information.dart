import 'package:flutter/material.dart';

import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/date_and_time_utils.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/view/widgets/information_widget_with_icon.dart';
import '../../models/public_profile_view_model.dart';
import 'information_container_rate_hole_path.dart';
import 'rate.dart';

class ProfileInformation extends StatelessWidget {
  final PublicProfileViewModel profileData;

  const ProfileInformation({
    required this.profileData,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.none,
        children: [
          ClipPath(
            clipper: InformationContainerRateHolePath(space: 135),
            child: _informationContainer(context),
          ),
          _rateWidget(),
        ],
      );

  Widget _rateWidget() => PositionedDirectional(
        top: -62,
        child: MemberRateWidget(
          rate: profileData.rate.toString(),
        ),
      );

  Widget _informationContainer(final BuildContext context) => DecoratedBox(
        decoration: _informationContainerDecoration(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Utils.smallSpace,
            80,
            Utils.smallSpace,
            Utils.smallSpace,
          ),
          child: _information(context),
        ),
      );

  Widget _information(final BuildContext context) => Column(
        children: [
          _otherInformation(context),
          Utils.smallVerticalSpacer,
          _address(context)
        ],
      );

  Widget _address(final BuildContext context) => InformationWidgetWithIcon(
        iconPath: 'lib/assets/menu_icons/address.png',
        label: 'آدرس:',
        value: profileData.address,
      );

  BoxDecoration _informationContainerDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,        ),
        color: CustomMilkyTheme.primaryColor.shade300,
      );

  Widget _otherInformation(final BuildContext context) => IntrinsicHeight(
        child: Row(
          children: [
            _nationalCodeAndMobileNumber(context),
            Utils.tinyHorizontalSpacer,
            _divider(),
            Utils.tinyHorizontalSpacer,
            _marriageAndBirthDate(context)
          ],
        ),
      );

  Widget _marriageAndBirthDate(final BuildContext context) => Expanded(
        child: Column(
          children: [
            _marriageStatus(context),
            Utils.smallVerticalSpacer,
            _birthDate(context),
          ],
        ),
      );

  Widget _birthDate(final BuildContext context) => InformationWidgetWithIcon(
        iconPath: 'lib/assets/menu_icons/calendar.png',
        label: 'تاریخ تولد:',
        value: DateAndTimeUtils.standardIranDateFormat(
          profileData.birthDate,
        ),
      );

  Widget _marriageStatus(final BuildContext context) =>
      InformationWidgetWithIcon(
        iconPath: 'lib/assets/menu_icons/mariage.png',
        label: 'وضعیت تاهل:',
        value: profileData.marriageStatus.name,
      );

  Widget _divider() => VerticalDivider(
        color: CustomMilkyTheme.primaryColor,
        width: 2,
      );

  Widget _nationalCodeAndMobileNumber(
    final BuildContext context,
  ) =>
      Expanded(
        child: Column(
          children: [
            _nationalCode(context),
            Utils.smallVerticalSpacer,
            _mobileNumber(context),
          ],
        ),
      );

  Widget _mobileNumber(
    final BuildContext context,
  ) =>
      InformationWidgetWithIcon(
        iconPath: 'lib/assets/menu_icons/mobile_number.png',
        label: 'شماره همراه:',
        value: profileData.mobileNumber,
      );

  Widget _nationalCode(
    final BuildContext context,
  ) =>
      InformationWidgetWithIcon(
        iconPath: 'lib/assets/menu_icons/national_id.png',
        label: 'کد ملی:',
        value: profileData.nationalCode,
      );
}
