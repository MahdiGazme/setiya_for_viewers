import 'package:get/get.dart';
import 'package:milky_http_client/milky_http_client.dart';

import '../../../../generated/locales.g.dart';
import '../../../../setia_module.dart';
import '../../../pages/shared/view/widgets/setiya_snackbar.dart';
import 'token_interceptor.dart';

class HttpClientUtils {
  HttpClientUtils._();

  static MilkyHttpClient httpClient({
    final String? baseUrl,
    final Map<String, dynamic>? headers,
    final bool showError = true,
  }) =>
      MilkyHttpClient(
        handleExceptionCallBack: (final exception) =>
            handleException(exception, showError: showError),
        interceptors: [
          TokenInterceptor(),
        ],
        sendTimeout: 20000,
        connectTimeout: 20000,
        receiveTimeout: 20000,
        exceptionPrefix: '',
        headers: headers,
        baseUrl: baseUrl ?? SetiaModuleParameters.fullBaseUrl,
      );

  static void handleException(
    final String exceptionKey, {
    final bool showError = true,
  }) {
    if (exceptionKey == 'cancel') {
      return;
    }

    if (showError) {
      SetiyaSnackbar().showSnackbar(
        'خطا',
        _translateException(exceptionKey),
        status: SetiyaSnackbarStatus.danger,
      );
    }
  }

  static String _translateException(final String exceptionKey) {
    const String prefix = 'setia_module_shared_exceptions_';
    final String key = '$prefix$exceptionKey';

    return _isKnownException(key) ? key.tr : 'خطای دیگر - $exceptionKey';
  }

  static bool _isKnownException(final String exceptionKey) =>
      Locales.fa_IR.containsKey(exceptionKey);
}
