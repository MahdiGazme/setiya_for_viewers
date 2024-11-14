import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../../shared/models/enums/member_marriage_status_enum.dart';


class AddManagementMemberDto {
  final String firstName;
  final String lastName;
  final String nationalCode;
  final String mobileNumber;
  final List<String> children;
  final Jalali birthDate;
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

  const AddManagementMemberDto({
    required this.firstName,
    required this.lastName,
    required this.nationalCode,
    required this.mobileNumber,
    required this.marriageStatus,
    required this.birthDate,
    required this.children,
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
        'children': children,
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
