class MemberAdditionalInformationDto {
  final String fatherName;
  final String? fatherJob;
  final String motherName;
  final String? motherMobileNumber;
  final String? telephone;
  final String address;

  MemberAdditionalInformationDto({
    required this.fatherName,
    required this.address,
    required this.motherName,
    this.fatherJob,
    this.motherMobileNumber,
    this.telephone,
  });

  Map<String, dynamic> toJson() => {
        'fatherName': fatherName,
        'fatherJob': fatherJob,
        'motherName': motherName,
        'motherMobileNumber': motherMobileNumber,
        'telephone': telephone,
        'address': address,
      };
}
