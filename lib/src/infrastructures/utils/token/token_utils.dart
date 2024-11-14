import 'dart:convert';

class TokenUtils {
  TokenUtils._();

  static Map<String, dynamic> parseToken(final String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final String payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    if (payloadMap.containsKey('exp')) {
      int expiresIn;

      try {
        expiresIn = payloadMap['exp'] is String
            ? int.parse(payloadMap['exp'])
            : payloadMap['exp'];
      } on FormatException {
        expiresIn = 0;
      }

      payloadMap['exp'] = expiresIn;
    }

    return payloadMap;
  }

  static String _decodeBase64(final String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  static bool isTokenExpired(
          final DateTime expireDate, final int secondBeforeExpire) =>
      expireDate.difference(DateTime.now()).inSeconds < secondBeforeExpire;
}
