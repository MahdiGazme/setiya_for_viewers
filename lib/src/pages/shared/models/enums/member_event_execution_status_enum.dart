enum MemberEventExecutionStatusEnum {

  registered._('ثبت نام شده', 1),
  present._('حضور', 2),
  canceled._('لغو', 3),
  absence._('غیبت', 4),
  await._('در انتظار تایید', 5);

  final String name;
  final int value;

  const MemberEventExecutionStatusEnum._(this.name, this.value);

  factory MemberEventExecutionStatusEnum.fromValue(final int value) {
    switch (value) {
      case 1:
        return MemberEventExecutionStatusEnum.registered;
      case 2:
        return MemberEventExecutionStatusEnum.present;
      case 3:
        return MemberEventExecutionStatusEnum.canceled;
      case 4:
        return MemberEventExecutionStatusEnum.absence;
      case 5:
        return MemberEventExecutionStatusEnum.await;
      default:
        return MemberEventExecutionStatusEnum.registered;
    }
  }

  factory MemberEventExecutionStatusEnum.fromIndex(final int index) {
    switch (index) {
      case 0:
        return MemberEventExecutionStatusEnum.registered;
      case 1:
        return MemberEventExecutionStatusEnum.present;
      case 2:
        return MemberEventExecutionStatusEnum.canceled;
      case 3:
        return MemberEventExecutionStatusEnum.absence;
      case 4:
        return MemberEventExecutionStatusEnum.await;
      default:
        return MemberEventExecutionStatusEnum.registered;
    }
  }
}
