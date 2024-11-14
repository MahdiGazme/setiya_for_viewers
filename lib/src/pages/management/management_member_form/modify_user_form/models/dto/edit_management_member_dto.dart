import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../../shared/models/enums/member_marriage_status_enum.dart';

class EditManagementMemberDto {
  final String firstName;
  final String lastName;
  final String nationalCode;
  final String mobileNumber;
  final Jalali birthDate;
  final List<String> newChildren;
  final List<String> deletedChildren;
  final String? avatarId;
  final String? fatherName;
  final String? fatherJob;
  final String? motherName;
  final String? motherMobile;
  final int? code;
  final MemberMarriageStatusEnum marriageStatus;
  final String? telephone;
  final String? address;
  final int? rate;

  const EditManagementMemberDto({
    required this.firstName,
    required this.lastName,
    required this.nationalCode,
    required this.mobileNumber,
    required this.marriageStatus,
    required this.birthDate,
    required this.newChildren,
    required this.deletedChildren,
    this.code,
    this.rate,
    this.avatarId,
    this.fatherName,
    this.fatherJob,
    this.motherName,
    this.motherMobile,
    this.address,
    this.telephone,
  });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'nationalCode': nationalCode,
        'mobile': mobileNumber,
        'newChildren': newChildren,
        'deletedChildren': deletedChildren,
        'avatarId': avatarId,
        'address': address,
        'fatherJob': fatherJob,
        'fatherName': fatherName,
        'motherName': motherName,
        'motherMobile': motherMobile,
        'marriageStatus': marriageStatus.status,
        'telephone': telephone,
        'rate': rate,
        'code': code,
        'birthDate': birthDate.toDateTime().toUtc().toIso8601String()
      };
}
