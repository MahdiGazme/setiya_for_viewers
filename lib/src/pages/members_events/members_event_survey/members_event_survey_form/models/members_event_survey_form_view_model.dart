class MembersEventSurveyFormViewModel {
  final String? imageId;
  final String title;

  MembersEventSurveyFormViewModel({
    required this.title,
    this.imageId,
  });

  factory MembersEventSurveyFormViewModel.fromJson(
    final Map<String, dynamic> json,
  ) =>
      MembersEventSurveyFormViewModel(
        title: json['title'],
        imageId: json['imageId'],
      );
}
