class MembersListItemViewModel {
  final String id;
  final String? avatarId;
  final String firstName;
  final String lastName;
  final int? membershipCode;

  const MembersListItemViewModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.membershipCode,
    this.avatarId,
  });

  factory MembersListItemViewModel.fromJson(final Map<String, dynamic> json) =>
      MembersListItemViewModel(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        avatarId: json['avatarId'],
        membershipCode: json['memberShipCode'],
      );
}
