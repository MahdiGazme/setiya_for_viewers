class MembershipRequestChildInformationViewModel {
  final String id;
  final String nationalCode;

  MembershipRequestChildInformationViewModel({
    required this.id,
    required this.nationalCode,
  });

  factory MembershipRequestChildInformationViewModel.fromJson(
          final Map<String, dynamic> json) =>
      MembershipRequestChildInformationViewModel(
        id: json['id'],
        nationalCode: json['nationalCode'],
      );
}
