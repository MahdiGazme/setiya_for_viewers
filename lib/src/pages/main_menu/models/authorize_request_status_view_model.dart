class AuthorizeRequestStatusViewModel {
  final bool hasRequest;

  AuthorizeRequestStatusViewModel({
    required this.hasRequest,
  });

  factory AuthorizeRequestStatusViewModel.fromJson(
          final Map<String, dynamic> json) =>
      AuthorizeRequestStatusViewModel(
        hasRequest: json['isInMembershipRequest'],
      );
}
