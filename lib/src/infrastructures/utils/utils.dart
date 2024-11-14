import 'package:flutter/material.dart';
import 'token/token_info.dart';

class Utils {
  Utils._();

  static const double tinySpace = 4;
  static const double smallSpace = 8;
  static const double mediumSpace = 16;
  static const double largeSpace = 24;
  static const double giantSpace = 32;

  static const double defaultResponsiveMaxWidth = 600;

  static const SizedBox tinyVerticalSpacer = SizedBox(height: tinySpace);
  static const SizedBox smallVerticalSpacer = SizedBox(height: smallSpace);
  static const SizedBox mediumVerticalSpacer = SizedBox(height: mediumSpace);
  static const SizedBox largeVerticalSpacer = SizedBox(height: largeSpace);
  static const SizedBox giantVerticalSpacer = SizedBox(height: giantSpace);

  static const SizedBox tinyHorizontalSpacer = SizedBox(width: tinySpace);
  static const SizedBox smallHorizontalSpacer = SizedBox(width: smallSpace);
  static const SizedBox mediumHorizontalSpacer = SizedBox(width: mediumSpace);
  static const SizedBox largeHorizontalSpacer = SizedBox(width: largeSpace);
  static const SizedBox giantHorizontalSpacer = SizedBox(width: giantSpace);

  static const EdgeInsetsDirectional tinyPadding =
      EdgeInsetsDirectional.all(tinySpace);
  static const EdgeInsetsDirectional smallPadding =
      EdgeInsetsDirectional.all(smallSpace);
  static const EdgeInsetsDirectional mediumPadding =
      EdgeInsetsDirectional.all(mediumSpace);
  static const EdgeInsetsDirectional largePadding =
      EdgeInsetsDirectional.all(largeSpace);
  static const EdgeInsetsDirectional giantPadding =
      EdgeInsetsDirectional.all(giantSpace);

  static const double cardElevation = 0;

  static const int searchDelay = 500;
  static const int filterDelay = 1000;
  static const int paginationLimit = 15;
  static const Duration searchDebouncerDuration =
      Duration(milliseconds: searchDelay);
  static const Duration filterDebouncerDuration =
      Duration(milliseconds: filterDelay);

  static const double smallAvatarSizeBeforeBreakpoint = 44;
  static const double smallAvatarSizeAfterBreakpoint = 56;
  static const double largeAvatarSizeBeforeBreakpoint = 104;
  static const double largeAvatarSizeAfterBreakpoint = 128;

  static const double smallSlidAbleActionExtentRatio = 0.15;
  static const double mediumSlidAbleActionExtentRatio = 0.38;

  static Map<String, String> get avatarHeader =>
      {'authorization': 'Bearer ${TokenInfo.token}'};

  static const String authorization = 'Authorization';

  static const String bearer = 'Bearer';

  static const String jsonContentType = 'application/json';

  static const String fullNameSearchFilterKey = 'searchText';

  static String treeDigitSeparate(
    final String number, {
    final String separator = ',',
  }) {
    String str = '';
    final numberSplit = number.split('.');
    for (var i = numberSplit.first.length; i > 0;) {
      str = i > 3
          ? separator + number.substring(i - 3, i) + str
          : number.substring(0, i) + str;
      i = i - 3;
    }
    if (numberSplit.length > 1) {
      str += '.${numberSplit[1]}';
    }

    return str;
  }

  static String? regularValidator(final String value) {
    if (value.isEmpty) {
      return 'این بخش نمیتواند خالی باشد';
    }

    return null;
  }

  static String removeDigitSeparator({
    required final String separator,
    required final String digit,
  }) =>
      digit.replaceAll(separator, '');
}
