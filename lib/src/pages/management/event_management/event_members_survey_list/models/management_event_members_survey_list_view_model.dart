class ManagementEventMembersSurveyListViewModel {
  final int commentId;
  final String firstName;
  final String lastName;
  final double rate;
  final String? avatarId;
  final String? shortComment;

  ManagementEventMembersSurveyListViewModel({
    required this.commentId,
    required this.firstName,
    required this.lastName,
    required this.rate,
    this.shortComment,
    this.avatarId,
  });

  factory ManagementEventMembersSurveyListViewModel.fromJson(
    final Map<String, dynamic> json,
  ) =>
      ManagementEventMembersSurveyListViewModel(
        commentId: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        rate: json['rate'] is int
            ? (json['rate'] as int).toDouble()
            : json['rate'],
        avatarId: json['avatarId'],
        shortComment: json['shortComment'],
      );
}
