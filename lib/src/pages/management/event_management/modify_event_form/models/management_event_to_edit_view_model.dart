import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../shared/models/enums/events_contact_type_enum.dart';

class ManagementEventToEditViewModel {
  final String? imageId;
  final String title;
  final String description;
  final int minimumRate;
  final int giftRate;
  final Jalali startDate;
  final Jalali endDate;
  final int? maxCapacity;
  final String address;
  final EventContactTypEnum contactType;
  final int? price;
  final bool needAcceptMember;

  ManagementEventToEditViewModel({
    required this.title,
    required this.description,
    required this.minimumRate,
    required this.giftRate,
    required this.startDate,
    required this.endDate,
    required this.address,
    required this.contactType,
    required this.needAcceptMember,
    this.imageId,
    this.maxCapacity,
    this.price,
  });

  factory ManagementEventToEditViewModel.fromJson(
          final Map<String, dynamic> json) =>
      ManagementEventToEditViewModel(
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
        address: json['address'],
        needAcceptMember: json['needAcceptMember'],
        contactType: EventContactTypEnum.fromValue(
          json['contactType'],
        ),
        imageId: json['imageId'],
        maxCapacity: json['maxCapacity'],
        price: json['price'],
      );
}
