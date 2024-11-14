class MemberEventSubmitRequestDto {
  final int eventId;

  MemberEventSubmitRequestDto({required this.eventId});

  Map<String, dynamic> toJson() => {
        'eventId': eventId,
      };
}
