class MemberAdditionalInformationViewModel {
  final String? fatherName;
  final String? fatherJob;
  final String? motherName;
  final String? motherMobileNumber;
  final String? telephone;
  final String? address;

  MemberAdditionalInformationViewModel({
    this.fatherJob,
    this.fatherName,
    this.address,
    this.motherMobileNumber,
    this.motherName,
    this.telephone,
  });

  factory MemberAdditionalInformationViewModel.fromJson(
          final Map<String, dynamic> json) =>
      MemberAdditionalInformationViewModel(
        fatherName: json['fatherName'],
        fatherJob: json['fatherJob'],
        motherName: json['motherName'],
        motherMobileNumber: json['motherMobileNumber'],
        telephone: json['telephone'],
        address: json['address'],
      );
}
