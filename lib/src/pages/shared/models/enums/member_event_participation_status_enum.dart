enum MemberEventParticipationStatusEnum {
  submit._(' ثبت نام شده', 1),
  present._('حاظر', 2),
  cancel._('لغو شده', 3),
  absence._('غیبت', 4);

  final String name;
  final int value;

  const MemberEventParticipationStatusEnum._(this.name, this.value);

  factory MemberEventParticipationStatusEnum.fromValue(final int value) {
    switch (value) {
      case 1:
        return MemberEventParticipationStatusEnum.submit;
      case 2:
        return MemberEventParticipationStatusEnum.present;
      case 3:
        return MemberEventParticipationStatusEnum.cancel;
      case 4:
        return MemberEventParticipationStatusEnum.absence;
      default:
        return MemberEventParticipationStatusEnum.submit;
    }
  }
}
