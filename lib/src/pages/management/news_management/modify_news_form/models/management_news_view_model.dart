import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class ManagementNewsViewModel {
  final List<String> imageIds;
  final String title;
  final String mainImageId;
  final String content;
  final Jalali? expireDate;

  ManagementNewsViewModel({
    required this.title,
    required this.mainImageId,
    required this.imageIds,
    required this.content,
    this.expireDate,
  });

  factory ManagementNewsViewModel.fromJson(final Map<String, dynamic> json) =>
      ManagementNewsViewModel(
        title: json['title'],
        imageIds: (json['imageIds'] as List)
            .map((final element) => element as String)
            .toList(),
        content: json['content'],
        mainImageId: json['mainImage'],
        expireDate: json['expireDate'] != null
            ? DateTime.parse(
          json['expireDate'],
        ).toLocal().toJalali()
            : null,
      );
}
