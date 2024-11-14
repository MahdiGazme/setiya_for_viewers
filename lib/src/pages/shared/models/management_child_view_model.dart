class ManagementChildViewModel {
  final String id;
  final String? avatarId;
  final String firstName;
  final String lastName;
  final int? membershipCode;

  const ManagementChildViewModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.membershipCode,
    this.avatarId,
  });

  factory ManagementChildViewModel.fromJson(final Map<String, dynamic> json) =>
      ManagementChildViewModel(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        avatarId: json['avatarId'],
        membershipCode: json['membershipCode'],
      );
}
