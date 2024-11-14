class SharedUserLoginDto {
  final String username;
  final String password;

  SharedUserLoginDto({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'userName': username,
        'password': password,
      };
}
