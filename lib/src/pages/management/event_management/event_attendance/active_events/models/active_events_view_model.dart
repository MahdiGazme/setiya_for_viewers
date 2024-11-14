import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../../shared/models/enums/events_contact_type_enum.dart';

class ActiveEventsListItemViewModel {
  final int id;
  final String? imageId;
  final String title;
  final Jalali startDate;
  final EventContactTypEnum contactType;

  ActiveEventsListItemViewModel({
    required this.id,
    required this.title,
    required this.contactType,
    required this.startDate,
    this.imageId,
  });

  factory ActiveEventsListItemViewModel.fromJson(
          final Map<String, dynamic> json) =>
      ActiveEventsListItemViewModel(
        id: json['id'],
        title: json['title'],
        contactType: EventContactTypEnum.fromValue(
          json['contactType'],
        ),
        startDate: DateTime.parse(json['startDate']).toLocal().toJalali(),
        imageId: json['imageId'],
      );
}
