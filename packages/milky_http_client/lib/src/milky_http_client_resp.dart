class MilkyHttpClientResponse<T> {
  MilkyHttpClientResponse({
    required this.data,
    required this.headers,
    required this.statusCode,
  });

  /// Response body
  T data;

  /// Response headers.
  Map<String, List<String>> headers;

  /// Http status code.
  int? statusCode;
}
