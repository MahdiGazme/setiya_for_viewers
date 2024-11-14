class NewsPreviewViewModel {
  final int newsId;
  final String imageId;
  final String title;

  NewsPreviewViewModel({
    required this.newsId,
    required this.imageId,
    required this.title,
  });

  factory NewsPreviewViewModel.fromJson(final Map<String, dynamic> json) =>
      NewsPreviewViewModel(
        newsId: json['newsId'],
        imageId: json['imageId'],
        title: json['title'],
      );
}
