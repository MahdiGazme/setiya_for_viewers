import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../shared/models/enums/member_marriage_status_enum.dart';

class PublicProfileViewModel {
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String nationalCode;
  final String? avatarId;
  final String? address;
  final MemberMarriageStatusEnum marriageStatus;
  final int rate;
  final int? memberShipCode;
  final Jalali birthDate;
  final bool additionalInformationCompletedBefore;

  PublicProfileViewModel({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.nationalCode,
    required this.marriageStatus,
    required this.rate,
    required this.mobileNumber,
    required this.additionalInformationCompletedBefore,
    this.avatarId,
    this.memberShipCode,
    this.address,
  });

  factory PublicProfileViewModel.fromJson(final Map<String, dynamic> json) =>
      PublicProfileViewModel(
        avatarId: json['avatarId'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        birthDate: DateTime.parse(
          json['birthDate'],
        ).toLocal().toJalali(),
        nationalCode: json['nationalCode'],
        marriageStatus: MemberMarriageStatusEnum.fromStatus(
          json['marriageStatus'],
        ),
        additionalInformationCompletedBefore:
            json['additionalInformationCompletedBefore'],
        rate: json['rate'] ?? 0,
        mobileNumber: json['mobileNumber'],
        address: json['address'],
        memberShipCode: json['memberShipCode'],
      );
}
