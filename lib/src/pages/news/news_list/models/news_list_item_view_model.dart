import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class NewsListItemViewModel {
  final String imageId;
  final int newsId;
  final String title;
  final String content;
  final Jalali releaseDate;

  NewsListItemViewModel({
    required this.title,
    required this.imageId,
    required this.newsId,
    required this.content,
    required this.releaseDate,
  });

  factory NewsListItemViewModel.fromJson(final Map<String, dynamic> json) =>
      NewsListItemViewModel(
        title: json['title'],
        imageId: json['imageId'],
        newsId: json['newsId'],
        content: json['content'],
        releaseDate: DateTime.parse(
          json['releaseDate'],
        ).toLocal().toJalali(),
      );
}
