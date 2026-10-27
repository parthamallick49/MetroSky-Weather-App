import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/utils/solar_calculator.dart';

void main() {
  group('SolarCalculator', () {
    test('calculates daylight elevation near solar noon at equator', () {
      // Equator on equinox around 12:00 UTC (lon: 0, lat: 0)
      final equinoxNoon = DateTime.utc(2026, 3, 20, 12, 0, 0);
      final position = SolarCalculator.calculate(
        latitude: 0.0,
        longitude: 0.0,
        utcDateTime: equinoxNoon,
      );

      // Solar elevation near noon at equator should be high (> 75 degrees)
      expect(position.elevationDegrees, greaterThan(75.0));
      expect(position.isDay, isTrue);
      expect(position.isTwilight, isFalse);
    });

    test('calculates negative elevation at midnight', () {
      final midnight = DateTime.utc(2026, 3, 20, 0, 0, 0);
      final position = SolarCalculator.calculate(
        latitude: 0.0,
        longitude: 0.0,
        utcDateTime: midnight,
      );

      expect(position.elevationDegrees, lessThan(-50.0));
      expect(position.isDay, isFalse);
    });

    test('identifies twilight elevation ranges properly', () {
      const civilTwilightPos = SolarPosition(
        elevationDegrees: -4.0,
        azimuthDegrees: 180.0,
      );
      expect(civilTwilightPos.isDay, isFalse);
      expect(civilTwilightPos.isTwilight, isTrue);
      expect(civilTwilightPos.isGoldenHour, isFalse);

      const goldenHourPos = SolarPosition(
        elevationDegrees: 3.5,
        azimuthDegrees: 90.0,
      );
      expect(goldenHourPos.isDay, isTrue);
      expect(goldenHourPos.isGoldenHour, isTrue);
    });
  });
}
