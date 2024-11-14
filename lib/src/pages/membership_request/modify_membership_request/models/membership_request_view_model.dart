import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../shared/models/enums/member_marriage_status_enum.dart';
import '../../shared/membership_request_child_information_view_model.dart';

class MembershipRequestViewModel {
  final String? avatarId;
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final Jalali birthDate;
  final MemberMarriageStatusEnum marriageStatus;
  final List<MembershipRequestChildInformationViewModel> children;

  MembershipRequestViewModel({
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.birthDate,
    required this.marriageStatus,
    required this.children,
    this.avatarId,
  });

  factory MembershipRequestViewModel.fromJson(
          final Map<String, dynamic> json) =>
      MembershipRequestViewModel(
        firstName: json['firstName'],
        lastName: json['lastName'],
        mobileNumber: json['mobileNumber'],
        birthDate: DateTime.parse(
          json['birthDate'],
        ).toLocal().toJalali(),
        marriageStatus: MemberMarriageStatusEnum.fromStatus(
          json['marriageStatus'],
        ),
        avatarId: json['avatarId'],
        children: (json['children'] as List)
            .map(
              (final element) =>
                  MembershipRequestChildInformationViewModel.fromJson(
                element as Map<String, dynamic>,
              ),
            )
            .toList(),
      );
}
