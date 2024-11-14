import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../shared/models/enums/events_contact_type_enum.dart';

class ManagementEventsListViewModel {
  final int id;
  final String? imageId;
  final String title;
  final int minimumRate;
  final Jalali startDate;
  final EventContactTypEnum contactType;

  ManagementEventsListViewModel({
    required this.id,
    required this.title,
    required this.minimumRate,
    required this.contactType,
    required this.startDate,
    this.imageId,
  });

  factory ManagementEventsListViewModel.fromJson(
          final Map<String, dynamic> json) =>
      ManagementEventsListViewModel(
        id: json['id'],
        title: json['title'],
        minimumRate: json['minimumRate'],
        contactType: EventContactTypEnum.fromValue(json['contactType']),
        startDate: DateTime.parse(
          json['startDate'],
        ).toLocal().toJalali(),
        imageId: json['imageId'],
      );
}
