class SignupDto {
  final String nationalCode;
  final String password;

  SignupDto({
    required this.nationalCode,
    required this.password,
  });

  Map<String, dynamic> toJson() =>
      {
        'nationalCode': nationalCode,
        'password': password,
      };
}
