import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import 'enums/events_contact_type_enum.dart';
import 'enums/member_event_execution_status_enum.dart';

class MembersEventHistoryDetailsViewModel {
  final String? imageId;
  final String title;
  final String description;
  final int minimumRate;
  final int giftRate;
  final Jalali startDate;
  final Jalali endDate;
  final MemberEventExecutionStatusEnum executionStatus;
  final int? maxCapacity;
  final int filledCapacity;
  final String address;
  final EventContactTypEnum contactType;
  final int? price;

  MembersEventHistoryDetailsViewModel({
    required this.title,
    required this.description,
    required this.minimumRate,
    required this.giftRate,
    required this.startDate,
    required this.endDate,
    required this.executionStatus,
    required this.filledCapacity,
    required this.address,
    required this.contactType,
    this.maxCapacity,
    this.price,
    this.imageId,
  });

  factory MembersEventHistoryDetailsViewModel.fromJason(
          final Map<String, dynamic> json) =>
      MembersEventHistoryDetailsViewModel(
        title: json['title'],
        description: json['description'],
        minimumRate: json['minimumRate'],
        giftRate: json['giftRate'],
        startDate: DateTime.parse(
          json['startDate'],
        ).toLocal().toJalali(),
        endDate: DateTime.parse(
          json['endDate'],
        ).toLocal().toJalali(),
        executionStatus: MemberEventExecutionStatusEnum.fromValue(
          json['executionStatus'],
        ),
        filledCapacity: json['filledCapacity'],
        maxCapacity: json['maxCapacity'],
        address: json['address'],
        contactType: EventContactTypEnum.fromValue(
          json['contactType'],
        ),
      );
}
