import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/utils/date_formatter.dart';

void main() {
  group('DateFormatterExtension', () {
    test('returns "Now" when hour and day match reference time', () {
      final now = DateTime(2026, 10, 27, 14, 30);
      final target = DateTime(2026, 10, 27, 14, 0);

      expect(target.toHourlyLabel(now: now), 'Now');
    });

    test('returns formatted hour for future hours', () {
      final now = DateTime(2026, 10, 27, 14, 30);
      final future = DateTime(2026, 10, 27, 16, 0);

      expect(future.toHourlyLabel(now: now), '4 PM');
    });

    test('returns "Today" and "Tomorrow" for daily labels', () {
      final now = DateTime(2026, 10, 27, 12, 0);
      final today = DateTime(2026, 10, 27, 18, 0);
      final tomorrow = DateTime(2026, 10, 28, 9, 0);
      final dayAfter = DateTime(2026, 10, 29, 9, 0);

      expect(today.toDailyLabel(now: now), 'Today');
      expect(tomorrow.toDailyLabel(now: now), 'Tomorrow');
      expect(dayAfter.toDailyLabel(now: now), 'Thu');
    });

    test('formats time string in 12-hour AM/PM format', () {
      final time = DateTime(2026, 10, 27, 6, 42);
      expect(time.toTimeString(), '6:42 AM');
    });
  });
}
