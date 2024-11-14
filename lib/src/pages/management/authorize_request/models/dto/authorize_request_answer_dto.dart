class AuthorizeRequestAnswerDto {
  final bool hasAccepted;

  AuthorizeRequestAnswerDto({
    required this.hasAccepted,
  });

  Map<String, dynamic> toJson() => {
        'hasAccepted': hasAccepted,
      };
}
