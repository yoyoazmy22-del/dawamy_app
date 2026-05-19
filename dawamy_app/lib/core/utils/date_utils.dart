import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();

  static final DateFormat _dayFormat = DateFormat('d');
  static final DateFormat _monthFormat = DateFormat('MMMM yyyy');
  static final DateFormat _monthYearFormat = DateFormat('MMM yyyy');
  static final DateFormat _timeFormat = DateFormat('h:mm a');
  static final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  static final DateFormat _dayNameFormat = DateFormat('EEEE');
  static final DateFormat _shortDayFormat = DateFormat('EEE');
  static final DateFormat _fullDateFormat = DateFormat('MMMM d, yyyy');

  static String formatDay(DateTime date) => _dayFormat.format(date);
  static String formatMonth(DateTime date) => _monthFormat.format(date);
  static String formatMonthYear(DateTime date) => _monthYearFormat.format(date);
  static String formatTime(DateTime date) => _timeFormat.format(date);
  static String formatDate(DateTime date) => _dateFormat.format(date);
  static String formatDayName(DateTime date) => _dayNameFormat.format(date);
  static String formatShortDay(DateTime date) => _shortDayFormat.format(date);
  static String formatFull(DateTime date) => _fullDateFormat.format(date);

  static DateTime get today => DateTime.now();
  static DateTime get tomorrow => today.add(const Duration(days: 1));

  static DateTime firstDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  static DateTime lastDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }

  static int daysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  static int firstWeekdayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1).weekday;
  }

  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static bool isSameMonth(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month;
  }

  static bool isToday(DateTime date) => isSameDay(date, today);

  static bool isWeekend(DateTime date) =>
      date.weekday == DateTime.friday || date.weekday == DateTime.saturday;

  static DateTime addMonths(DateTime date, int months) {
    return DateTime(date.year, date.month + months, date.day);
  }

  static String formatTimeRange(DateTime start, DateTime end) {
    return '${formatTime(start)} - ${formatTime(end)}';
  }

  static List<DateTime> getDaysInMonth(DateTime date) {
    final days = <DateTime>[];
    final totalDays = daysInMonth(date);
    for (int i = 1; i <= totalDays; i++) {
      days.add(DateTime(date.year, date.month, i));
    }
    return days;
  }

  static List<DateTime> getMonthGrid(DateTime date) {
    final firstDay = firstDayOfMonth(date);
    final lastDay = lastDayOfMonth(date);
    final startWeekday = firstDay.weekday % 7;
    final days = <DateTime>[];
    for (int i = 0; i < startWeekday; i++) {
      days.add(firstDay.subtract(Duration(days: startWeekday - i)));
    }
    for (int i = 0; i <= lastDay.day - firstDay.day; i++) {
      days.add(firstDay.add(Duration(days: i)));
    }
    final remaining = 42 - days.length;
    for (int i = 0; i < remaining; i++) {
      days.add(lastDay.add(Duration(days: i + 1)));
    }
    return days;
  }
}
