import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../shared/models/enums/events_contact_type_enum.dart';

class MembersEventSurveyListViewModel {
  final int id;
  final String? imageId;
  final String title;
  final int minimumRate;
  final Jalali endDate;
  final EventContactTypEnum contactType;

  MembersEventSurveyListViewModel({
    required this.id,
    required this.title,
    required this.minimumRate,
    required this.contactType,
    required this.endDate,
    this.imageId,
  });

  factory MembersEventSurveyListViewModel.fromJson(
          final Map<String, dynamic> json) =>
      MembersEventSurveyListViewModel(
        id: json['id'],
        title: json['title'],
        minimumRate: json['minimumRate'],
        contactType: EventContactTypEnum.fromValue(json['contactType']),
        endDate: DateTime.parse(
          json['endDate'],
        ).toLocal().toJalali(),
        imageId: json['imageId'],
      );
}
