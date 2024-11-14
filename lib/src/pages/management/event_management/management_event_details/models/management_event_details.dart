import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../shared/models/enums/events_contact_type_enum.dart';

class ManagementEventDetailsViewModel {
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
  final bool needAcceptMember;
  final bool isExecuted;
  final double? averageOfRate;

  ManagementEventDetailsViewModel({
    required this.title,
    required this.description,
    required this.minimumRate,
    required this.giftRate,
    required this.startDate,
    required this.endDate,
    required this.filledCapacity,
    required this.address,
    required this.contactType,
    required this.needAcceptMember,
    required this.isExecuted,
    this.averageOfRate,
    this.imageId,
    this.maxCapacity,
    this.price,
  });

  factory ManagementEventDetailsViewModel.fromJson(
          final Map<String, dynamic> json) =>
      ManagementEventDetailsViewModel(
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
        filledCapacity: json['filledCapacity'],
        address: json['address'],
        needAcceptMember: json['needAcceptMember'],
        contactType: EventContactTypEnum.fromValue(
          json['contactType'],
        ),
        imageId: json['imageId'],
        maxCapacity: json['maxCapacity'],
        price: json['price'],
        isExecuted: json['isExecuted'],
        averageOfRate: json['averageOfRate'] is int
            ? (json['averageOfRate'] as int).toDouble()
            : json['averageOfRate'],
      );
}
