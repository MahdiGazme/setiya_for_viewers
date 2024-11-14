import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../shared/models/enums/member_marriage_status_enum.dart';

class MembershipRequestDto {
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final Jalali birthDate;
  final MemberMarriageStatusEnum marriageStatus;
  final String? avatarId;
  final List<String> newChildren;
  final List<String> deletedChildren;

  MembershipRequestDto(
      {required this.firstName,
      required this.lastName,
      required this.mobileNumber,
      required this.birthDate,
      required this.marriageStatus,
      required this.newChildren,
      required this.deletedChildren,
      this.avatarId});

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'mobileNumber': mobileNumber,
        'birthDate': birthDate.toDateTime().toUtc().toIso8601String(),
        'marriageStatus': marriageStatus.status,
        'avatarId': avatarId,
        'newChildren': newChildren
            .map(
              (final element) => element,
            )
            .toList(),
        'deletedChildren': deletedChildren
            .map(
              (final element) => element,
            )
            .toList(),
      };
}
