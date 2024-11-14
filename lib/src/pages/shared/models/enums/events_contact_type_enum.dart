enum EventContactTypEnum {
  justMembers._('فقط اعضا', 1),
  membersWithMother._('همراه با مادر', 2),
  justMothers._('فقط مادران', 3);

  final String name;
  final int value;

  const EventContactTypEnum._(this.name, this.value);

  factory EventContactTypEnum.fromValue(final int value) {
    switch (value) {
      case 1:
        return EventContactTypEnum.justMembers;
      case 2:
        return EventContactTypEnum.membersWithMother;
      case 3:
        return EventContactTypEnum.justMothers;
      default:
        return EventContactTypEnum.justMembers;
    }
  }
}
