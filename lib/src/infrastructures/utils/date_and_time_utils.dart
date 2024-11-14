import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class DateAndTimeUtils {
  DateAndTimeUtils._();

  static String dateWithMountNameFormatter(final Jalali? pickedDate) =>
      pickedDate != null
          ? '${pickedDate.formatter.dd} ${pickedDate.formatter.mN} '
              '${pickedDate.formatter.yyyy}'
          : '';

  static String timeFormatter(final TimeOfDay? pickedDate) => pickedDate != null
      ? '${pickedDate.hour < 10 ? '0${pickedDate.hour}' : pickedDate.hour}:'
          '${pickedDate.minute < 10 ? '0'
              '${pickedDate.minute}' : pickedDate.minute}'
      : '';

  static String dateWithMountNameRangeFormatter(final JalaliRange? pickedDate) {
    if (pickedDate != null) {
      if (pickedDate.start.julianDayNumber == pickedDate.end.julianDayNumber) {
        return DateAndTimeUtils.standardIranDateFormat(pickedDate.start);
      } else {
        return '${DateAndTimeUtils.standardIranDateFormat(pickedDate.start)}'
            ' تا ${DateAndTimeUtils.standardIranDateFormat(pickedDate.end)}';
      }
    }

    return '';
  }

  static String standardIranDateFormat(final Jalali date) {
    final formatter = date.formatter;

    return '${formatter.yyyy}/${formatter.mm}/${formatter.dd}';
  }

  static String standardIranDateFormat2(final Jalali date) {
    final formatter = date.formatter;

    return '${formatter.yyyy}/${formatter.mm}/${formatter.dd}';
  }

  static String standardDateRangeFormatter(
    final Jalali startDate,
    final Jalali endDate,
  ) =>
      startDate.julianDayNumber != endDate.julianDayNumber
          ? '${DateAndTimeUtils.standardIranDateFormat(startDate)} تا'
              ' ${DateAndTimeUtils.standardIranDateFormat(endDate)}'
          : DateAndTimeUtils.standardIranDateFormat(startDate);

  // checks if time of event is from start of the day to end of the same
  //day returns null but if the start time is after 00:00  and end time is
  // 23:59 returns only start time  and if the start date and end date are
  // different returns a time range;

  static String? timeRangeFormatter(
    final Jalali startDate,
    final Jalali endDate,
  ) {
    final startTimeToDouble = startDate.hour + startDate.minute / 60.0;

    final endTimeToDouble = endDate.hour + endDate.minute / 60.0;

    if (startTimeToDouble == 0 && endTimeToDouble == 23.983333333333334) {
      return null;
    } else if (endTimeToDouble == 23.983333333333334) {
      return DateAndTimeUtils.timeFormatter(
        TimeOfDay(
          hour: startDate.hour,
          minute: startDate.minute,
        ),
      );
    } else {
      return '${DateAndTimeUtils.timeFormatter(
        TimeOfDay(
          hour: startDate.hour,
          minute: startDate.minute,
        ),
      )} تا ${DateAndTimeUtils.timeFormatter(
        TimeOfDay(
          hour: endDate.hour,
          minute: endDate.minute,
        ),
      )}';
    }
  }
}
