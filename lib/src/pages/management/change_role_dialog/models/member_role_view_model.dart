class MemberRoleViewModel {
  final String role;

  MemberRoleViewModel({
    required this.role,
  });

  factory MemberRoleViewModel.fromJson(final Map<String, dynamic> json) =>
      MemberRoleViewModel(
        role: json['role'],
      );
}
