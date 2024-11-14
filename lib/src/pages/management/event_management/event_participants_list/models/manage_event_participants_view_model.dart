class ManageEventParticipantViewModel {
  final String id;
  final String? avatarId;
  final bool hasAccepted;
  final String firstName;
  final String lastName;
  final int? memberCode;

  const ManageEventParticipantViewModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.hasAccepted,
    this.memberCode,
    this.avatarId,
  });

  factory ManageEventParticipantViewModel.fromJson(
      final Map<String, dynamic> json) =>
      ManageEventParticipantViewModel(
        id: json['id'],
        hasAccepted: json['hasAccepted'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        avatarId: json['avatarId'],
        memberCode: json['memberCode'],
      );
}