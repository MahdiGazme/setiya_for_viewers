class ChangeRoleDto{
  final String role;

  ChangeRoleDto({
    required this.role,
  });

  Map<String, dynamic> toJson() => {
        'role': role,
      };
}
