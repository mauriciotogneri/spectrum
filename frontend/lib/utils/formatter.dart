import 'package:intl/intl.dart';

class Formatter {
  static String dayShortMonthYearPattern() {
    final String pattern = DateFormat.yMd().pattern ?? '';

    return pattern.toLowerCase().replaceAll('y', 'yyyy');
  }

  static String dayLongMonthMonthYear(DateTime dateTime) =>
      DateFormat.yMMMd().format(dateTime.toLocal());

  static String hoursMinutes(DateTime dateTime) =>
      DateFormat.Hm().format(dateTime.toLocal());

  static String fullDateTime(DateTime dateTime) {
    final String date = dayLongMonthMonthYear(dateTime);
    final String time = hoursMinutes(dateTime);

    return '$date $time';
  }
}
