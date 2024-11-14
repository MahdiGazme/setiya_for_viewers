import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../shared/models/enums/events_contact_type_enum.dart';

class MembersEventDetailsViewModel {
  final String? imageId;
  final String title;
  final String description;
  final int minimumRate;
  final int giftRate;
  final Jalali startDate;
  final Jalali endDate;
  final int? maxCapacity;
  final int filledCapacity;
  final String address;
  final EventContactTypEnum contactType;
  final int? price;
  final bool needToAcceptByManager;

  MembersEventDetailsViewModel({
    required this.title,
    required this.description,
    required this.minimumRate,
    required this.giftRate,
    required this.startDate,
    required this.endDate,
    required this.filledCapacity,
    required this.address,
    required this.contactType,
    required this.needToAcceptByManager,
    this.imageId,
    this.maxCapacity,
    this.price,
  });

  factory MembersEventDetailsViewModel.fromJson(
          final Map<String, dynamic> json) =>
      MembersEventDetailsViewModel(
        title: json['title'],
        description: json['description'],
        minimumRate: json['minimumRate'],
        giftRate: json['giftRate'],
        startDate: DateTime.parse(json['startDate']).toLocal().toJalali(),
        endDate: DateTime.parse(json['endDate']).toLocal().toJalali(),
        filledCapacity: json['filledCapacity'],
        address: json['address'],
        needToAcceptByManager: json['needAcceptMember'],
        contactType: EventContactTypEnum.fromValue(
          json['contactType'],
        ),
        imageId: json['imageId'],
        maxCapacity: json['maxCapacity'],
        price: json['price'],
      );
}
