class MembersEventSurveyFormDto {
  final double rate;
  final String? comment;

  MembersEventSurveyFormDto({
    required this.rate,
    this.comment,
  });

  Map<String, dynamic> toJson() => {
        'rate': rate,
        'comment': comment,
      };
}
