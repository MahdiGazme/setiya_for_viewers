class ChildrenListItemViewModel {
  final String id;
  final String? avatarId;
  final String firstName;
  final String lastName;
  final int? membershipCode;

  const ChildrenListItemViewModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.membershipCode,
    this.avatarId,
  });

  factory ChildrenListItemViewModel.fromJson(final Map<String, dynamic> json) =>
      ChildrenListItemViewModel(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        avatarId: json['avatarId'],
        membershipCode: json['membershipCode'],
      );
}
