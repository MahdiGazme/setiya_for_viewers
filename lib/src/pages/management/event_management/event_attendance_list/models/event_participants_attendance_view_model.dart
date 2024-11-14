class EventParticipantsAttendanceViewModel {
  final String id;
  final String? avatarId;
  final String firstName;
  final String lastName;
  final int? memberCode;

  const EventParticipantsAttendanceViewModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.memberCode,
    this.avatarId,
  });

  factory EventParticipantsAttendanceViewModel.fromJson(
          final Map<String, dynamic> json) =>
      EventParticipantsAttendanceViewModel(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        avatarId: json['avatarId'],
        memberCode: json['memberCode'],
      );
}
