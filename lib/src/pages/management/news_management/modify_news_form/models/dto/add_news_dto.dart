import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class AddNewsDto {
  final List<String> imageIds;
  final String mainImageId;
  final String title;
  final String content;
  final Jalali? expireDate;

  AddNewsDto({
    required this.imageIds,
    required this.mainImageId,
    required this.title,
    required this.content,
    this.expireDate,
  });

  Map<String, dynamic> toJson() => {
        'imageId': imageIds,
        'mainImageId': mainImageId,
        'title': title,
        'content': content,
        'expireDate': expireDate != null
            ? expireDate!.toDateTime().toUtc().toIso8601String()
            : null,
      };
}
