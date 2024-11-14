class EventMemberCommentViewModel {
  final String memberId;
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final double rate;
  final String? comment;
  final String? avatarId;

  EventMemberCommentViewModel({
    required this.memberId,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.rate,
    this.comment,
    this.avatarId,
  });

  factory EventMemberCommentViewModel.fromJson(
          final Map<String, dynamic> json) =>
      EventMemberCommentViewModel(
        memberId: json['memberId'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        mobileNumber: json['mobileNumber'],
        rate: json['rate'] is int
            ? (json['rate'] as int).toDouble()
            : json['rate'],
        comment: json['comment'],
        avatarId: json['avatarId'],
      );
}
