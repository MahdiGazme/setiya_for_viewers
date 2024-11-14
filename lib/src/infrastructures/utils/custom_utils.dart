import 'utils.dart';

class CustomUtils {
  CustomUtils._();

  static String? nationalCodeValidator(
    final String value,
    final String errorMessage,
  ) {
    final regex = RegExp(r'^([0-9]{10})$');
    final result = regex.allMatches(value).toList();
    if (result.isNotEmpty) {
      final List<int> inputCharacters = [];
      for (var i = 9; i >= 0; i--) {
        inputCharacters.add(int.parse(value[i]));
      }
      int summery = 0;
      for (var i = 1; i <= inputCharacters.length - 1; i++) {
        summery += inputCharacters[i] * (i + 1);
      }

      final remainder = summery % 11;

      if (remainder < 2) {
        if (inputCharacters[0] == remainder) {
          return null;
        } else {
          return errorMessage;
        }
      } else if (remainder >= 2) {
        if (11 - remainder == inputCharacters[0]) {
          return null;
        } else {
          return errorMessage;
        }
      } else {
        return errorMessage;
      }
    } else {
      return errorMessage;
    }
  }

  static String? mobileNumberValidator(
    final String value,
    final String errorMessage,
  ) {
    final regex = RegExp(r'(^09|9)([0-9]{2})([0-9]{3})([0-9]{4})$');
    final result = regex.allMatches(value).toList();

    return result.isNotEmpty ? null : errorMessage;
  }

  static String? telephoneNumberValidator(
    final String value,
    final String errorMessage,
  ) {
    final regex = RegExp(r'^(0?)([1-9]{3})([0-9]{3})([0-9]{4})$');
    final result = regex.allMatches(value).toList();

    return result.isNotEmpty ? null : errorMessage;
  }

  static String? passwordValidator(
    final String value,
    final String errorMessage,
  ) {
    final emptyError = Utils.regularValidator(value);
    if (emptyError != null) {
      return emptyError;
    }
    final regex = RegExp(r'^[^-\s]{8,12}$');
    final result = regex.allMatches(value).toList();

    return result.isNotEmpty ? null : errorMessage;
  }

  static String? repeatPasswordValidator(
    final String value,
    final String password,
    final String errorMessage,
  ) {
    final emptyError = Utils.regularValidator(value);
    if (emptyError != null) {
      return emptyError;
    } else if (value != password) {
      return errorMessage;
    }

    return null;
  }

  static String calculateEventFreeSpace(
    final int? maxCapacity,
    final int filledCapacity,
  ) =>
      maxCapacity != null
          ? '${maxCapacity - filledCapacity} از'
              ' $maxCapacity نفر'
          : 'نامحدود';
}
