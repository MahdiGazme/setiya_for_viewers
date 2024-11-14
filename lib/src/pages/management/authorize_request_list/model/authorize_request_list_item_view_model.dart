class AuthorizeRequestListItemViewModel {
  final String id;
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String? avatarId;

  AuthorizeRequestListItemViewModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    this.avatarId,
  });

  factory AuthorizeRequestListItemViewModel.fromJson(
    final Map<String, dynamic> json,
  ) =>
      AuthorizeRequestListItemViewModel(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        mobileNumber: json['mobileNumber'],
        avatarId: json['avatarId'],
      );
}
