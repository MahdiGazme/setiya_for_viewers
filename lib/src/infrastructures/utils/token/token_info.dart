import 'package:get_storage/get_storage.dart';

import '../../commons/storage_keys.dart';
import '../../role_management/setiya_role_enum.dart';
import '../utils.dart';
import 'session_model.dart';
import 'token_utils.dart';

class TokenInfo {
  static SessionModel? _sessionModel;
  static GetStorage? _storage;

  TokenInfo._();

  static String get token => isLoggedIn
      ? _storage!.read(StorageKeys.token)!
      : throw _exceptionError;

  static String get id =>
      isLoggedIn ? _sessionModel!.id : throw _exceptionError;

  static List<SetiyaRoleEnum> get roles =>
      isLoggedIn ? _sessionModel!.roles : throw _exceptionError;

  static bool get isTokenExpired => isLoggedIn
      ? TokenUtils.isTokenExpired(_sessionModel!.expireDate, 60)
      : throw _exceptionError;

  static bool get isLoggedIn => _sessionModel != null;

  static Map<String, String> header() => {
        if (isLoggedIn) Utils.authorization: '${Utils.bearer} $token',
      };

  static void clearToken() {
    _sessionModel = null;
    _storage?.remove(StorageKeys.token);
  }

  /// call this after get token from response
  static Future<void> initialize(final String token) async {
    _storage = GetStorage();
    await _storage!.write(StorageKeys.token, token);
    _sessionModel = SessionModel.fromJson(
      TokenUtils.parseToken(token),
    );
  }

  static final _exceptionError = Exception('user is not logged in\n'
      'Check TokenInfo.isLoggedIn before calling this');
}
