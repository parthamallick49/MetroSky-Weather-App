import 'package:intl/intl.dart';

/// Extension methods on [DateTime] providing clean, localized meteorological date and time strings.
extension DateFormatterExtension on DateTime {
  /// Returns a clean hourly label for the forecast timeline.
  /// If the hour matches [now], returns 'Now'. Otherwise returns '3 PM', '11 AM', etc.
  String toHourlyLabel({DateTime? now}) {
    final current = now ?? DateTime.now();
    if (year == current.year &&
        month == current.month &&
        day == current.day &&
        hour == current.hour) {
      return 'Now';
    }
    return DateFormat('h a').format(this);
  }

  /// Returns a clean daily label for weekly forecasts.
  /// Example: 'Today', 'Tomorrow', 'Wed', 'Thu'.
  String toDailyLabel({DateTime? now}) {
    final current = now ?? DateTime.now();
    final today = DateTime(current.year, current.month, current.day);
    final target = DateTime(year, month, day);
    final difference = target.difference(today).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    return DateFormat('EEE').format(this);
  }

  /// Formats time in 12-hour format with AM/PM.
  /// Example: '6:42 AM'
  String toTimeString() {
    return DateFormat('h:mm a').format(this);
  }

  /// Formats full human-readable date.
  /// Example: 'Wednesday, October 28'
  String toFullDateString() {
    return DateFormat('EEEE, MMMM d').format(this);
  }
}
