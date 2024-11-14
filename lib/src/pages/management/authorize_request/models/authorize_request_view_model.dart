import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../shared/models/enums/member_marriage_status_enum.dart';
import '../../../shared/models/management_child_view_model.dart';

class AuthorizeRequestViewModel {
  final String? avatarId;
  final String firstName;
  final String nationalCode;
  final String lastName;
  final String mobileNumber;
  final Jalali birthDate;
  final MemberMarriageStatusEnum marriageStatus;
  final List<ManagementChildViewModel> children;

  AuthorizeRequestViewModel({
    required this.firstName,
    required this.lastName,
    required this.nationalCode,
    required this.mobileNumber,
    required this.birthDate,
    required this.marriageStatus,
    required this.children,
    this.avatarId,
  });

  factory AuthorizeRequestViewModel.fromJson(final Map<String, dynamic> json) =>
      AuthorizeRequestViewModel(
        firstName: json['firstName'],
        lastName: json['lastName'],
        nationalCode: json['nationalCode'],
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
              (final element) => ManagementChildViewModel.fromJson(
                element as Map<String, dynamic>,
              ),
            )
            .toList(),
      );
}
