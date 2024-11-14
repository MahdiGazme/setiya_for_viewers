import 'package:milky_http_client/milky_http_client.dart';

import '../token/token_info.dart';
import '../utils.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(
    final RequestOptions options,
    final RequestInterceptorHandler handler,
  ) async {
    // await persistToken;

    if (options.responseType != ResponseType.bytes) {
      options.headers[Headers.contentTypeHeader] = Utils.jsonContentType;
    }

    options.headers.addAll(TokenInfo.header());

    super.onRequest(options, handler);
  }
}
