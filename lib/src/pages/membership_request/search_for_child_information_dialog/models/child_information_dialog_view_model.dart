class ChildInformationDialogViewModel {
  final String id;

  ChildInformationDialogViewModel({
    required this.id,
  });

  factory ChildInformationDialogViewModel.fromJson(
          final Map<String, dynamic> json) =>
      ChildInformationDialogViewModel(
        id: json['id'],
      );
}
