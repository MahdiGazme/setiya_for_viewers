import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../infrastructures/role_management/setiya_role_enum.dart';
import 'enums/member_marriage_status_enum.dart';
import 'management_child_view_model.dart';

class MemberDetailsViewModel {
  final String id;
  final String firstName;
  final String lastName;
  final String nationalCode;
  final String mobileNumber;
  final String? avatarId;
  final String? fatherName;
  final String? fatherJob;
  final int? membershipCode;
  final String? motherName;
  final String? motherPhoneNumber;
  final MemberMarriageStatusEnum marriageStatus;
  final SetiyaRoleEnum role;
  final String? telephone;
  final String? address;
  final int rate;
  final Jalali? birthDate;
  final List<ManagementChildViewModel> children;

  const MemberDetailsViewModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.nationalCode,
    required this.mobileNumber,
    required this.marriageStatus,
    required this.rate,
    required this.role,
    required this.children,
    this.birthDate,
    this.membershipCode,
    this.avatarId,
    this.fatherName,
    this.fatherJob,
    this.motherName,
    this.motherPhoneNumber,
    this.address,
    this.telephone,
  });

  factory MemberDetailsViewModel.fromJson(final Map<String, dynamic> json) =>
      MemberDetailsViewModel(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        nationalCode: json['nationalCode'],
        mobileNumber: json['mobileNumber'],
        role: SetiyaRoleEnum.fromValue(
          json['role'],
        ),
        fatherJob: json['fatherJob'],
        fatherName: json['fatherName'],
        motherName: json['motherName'],
        avatarId: json['avatarId'],
        motherPhoneNumber: json['motherPhoneNumber'],
        marriageStatus:
            MemberMarriageStatusEnum.fromStatus(json['marriageStatus']),
        telephone: json['telephone'],
        address: json['address'],
        membershipCode: json['memberShipCode'],
        rate: json['rate'],
        birthDate: json['birthDate'] != null
            ? DateTime.parse(
                json['birthDate'],
              ).toLocal().toJalali()
            : null,
        children: (json['children'] as List)
            .map(
              (final element) => ManagementChildViewModel.fromJson(
                element as Map<String, dynamic>,
              ),
            )
            .toList(),
      );
}
