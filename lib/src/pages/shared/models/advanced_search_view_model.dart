import 'advanced_search_type.dart';

class AdvancedQueryViewModel {
  String key;
  String? text;
  String startValue;
  String? endValue;
  AdvancedSearchType type;
  bool show;

  AdvancedQueryViewModel({
    required this.key,
    required this.startValue,
    this.text,
    this.type = AdvancedSearchType.equals,
    this.endValue,
    this.show = true,
  });

  @override
  String toString() => key;
}
