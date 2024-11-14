import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class NewsViewModel {
  final List<String> imageIds;
  final String title;
  final String content;
  final Jalali releaseDate;

  NewsViewModel({
    required this.title,
    required this.imageIds,
    required this.content,
    required this.releaseDate,
  });

  factory NewsViewModel.fromJson(final Map<String, dynamic> json) =>
      NewsViewModel(
        title: json['title'],
        imageIds: (json['imageIds'] as List)
            .map((final element) => element as String)
            .toList(),
        content: json['content'],
        releaseDate: DateTime.parse(
          json['releaseDate'],
        ).toLocal().toJalali(),
      );
}
