class MembersListItemForAddToEventViewModel {
  final String id;
  final String? avatarId;
  final bool doesRegisterAnyEventInSameTime;
  final String firstName;
  final String lastName;
  final int? code;

  const MembersListItemForAddToEventViewModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.doesRegisterAnyEventInSameTime,
    this.code,
    this.avatarId,
  });

  factory MembersListItemForAddToEventViewModel.fromJson(
          final Map<String, dynamic> json) =>
      MembersListItemForAddToEventViewModel(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        doesRegisterAnyEventInSameTime: json['doesRegisterAnyEventInSameTime'],
        avatarId: json['avatarId'],
        code: json['memberCode'],
      );
}
