class DeleteNewsDto {
  final List<int> newsIds;

  DeleteNewsDto({required this.newsIds});

  Map<String, dynamic> toJson() => {
        'newsIds': newsIds,
      };
}
