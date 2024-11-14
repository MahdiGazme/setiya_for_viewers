
enum MemberMarriageStatusEnum {
  single._(1, 'مجرد'),
  married._(2, 'متاهل');

  final String name;
  final int status;

  const MemberMarriageStatusEnum._(
    this.status,
    this.name,
  );

  factory MemberMarriageStatusEnum.fromStatus(final int status) {
    switch (status) {
      case 1:
        return MemberMarriageStatusEnum.single;
      case 2:
        return MemberMarriageStatusEnum.married;
      default:
        return MemberMarriageStatusEnum.single;
    }
  }
}

