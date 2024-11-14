import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class EditNewsDto {
  final List<String>? newImageIds;
  final List<String>? deletedImageIds;
  final String mainImageId;
  final String title;
  final String content;
  final Jalali? expireDate;

  EditNewsDto({
    required this.mainImageId,
    required this.title,
    required this.content,
    this.newImageIds,
    this.deletedImageIds,
    this.expireDate,
  });

  Map<String, dynamic> toJson() => {
        'newImageIds': newImageIds,
        'deletedImageIds': deletedImageIds,
        'mainImageId': mainImageId,
        'title': title,
        'content': content,
        'expireDate': expireDate != null
            ? expireDate!.toDateTime().toUtc().toIso8601String()
            : null,
      };
}
