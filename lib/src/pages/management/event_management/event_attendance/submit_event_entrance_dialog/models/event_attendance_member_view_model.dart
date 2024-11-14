import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class EventAttendanceMemberViewModel {
  final String id;
  final String? avatarId;
  final String firstName;
  final String lastName;
  final int? membershipCode;
  final Jalali birthDate;
  final String mobileNumber;
  final bool isEventMember;

  EventAttendanceMemberViewModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.isEventMember,
    required this.mobileNumber,
    this.avatarId,
    this.membershipCode,
  });

  factory EventAttendanceMemberViewModel.fromJson(
    final Map<String, dynamic> json,
  ) =>
      EventAttendanceMemberViewModel(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        birthDate: DateTime.parse(json['birthDate']).toLocal().toJalali(),
        isEventMember: json['isEventMember'],
        mobileNumber: json['mobileNumber'],
        avatarId: json['avatarId'],
        membershipCode: json['membershipCode'],
      );
}
