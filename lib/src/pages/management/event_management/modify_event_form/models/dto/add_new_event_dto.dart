import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../../shared/models/enums/events_contact_type_enum.dart';

class AddNewEventDto {
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

  AddNewEventDto({
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

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'minimumRate': minimumRate,
        'giftRate': giftRate,
        'startDate': startDate.toDateTime().toUtc().toIso8601String(),
        'endDate': endDate.toDateTime().toUtc().toIso8601String(),
        'address': address,
        'contactType': contactType.value,
        'needAcceptMember': needAcceptMember,
        'imageId': imageId,
        'maxCapacity': maxCapacity,
        'price': price,
      };
}
