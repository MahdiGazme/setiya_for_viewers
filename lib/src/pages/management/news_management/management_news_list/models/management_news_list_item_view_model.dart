import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class ManagementNewsListItemViewModel {
  final String imageId;
  final int newsId;
  final String title;
  final String content;
  final Jalali releaseDate;
  final Jalali? expireDate;

  ManagementNewsListItemViewModel({
    required this.title,
    required this.imageId,
    required this.newsId,
    required this.content,
    required this.releaseDate,
    this.expireDate,
  });

  factory ManagementNewsListItemViewModel.fromJson(
          final Map<String, dynamic> json) =>
      ManagementNewsListItemViewModel(
        title: json['title'],
        imageId: json['imageId'],
        newsId: json['newsId'],
        content: json['content'],
        releaseDate: DateTime.parse(
          json['releaseDate'],
        ).toLocal().toJalali(),
        expireDate: json['expireDate'] != null
            ? DateTime.parse(
          json['expireDate'],
        ).toLocal().toJalali()
            : null,
      );
}
