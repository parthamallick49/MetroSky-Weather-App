import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/utils/temperature_formatter.dart';

void main() {
  group('TemperatureFormatter', () {
    test('converts Celsius to Fahrenheit accurately', () {
      expect(TemperatureFormatter.toFahrenheit(0), 32.0);
      expect(TemperatureFormatter.toFahrenheit(100), 212.0);
      expect(TemperatureFormatter.toFahrenheit(-40), -40.0);
      expect(TemperatureFormatter.toFahrenheit(20), 68.0);
    });

    test('converts Fahrenheit to Celsius accurately', () {
      expect(TemperatureFormatter.toCelsius(32), 0.0);
      expect(TemperatureFormatter.toCelsius(212), 100.0);
      expect(TemperatureFormatter.toCelsius(-40), -40.0);
      expect(TemperatureFormatter.toCelsius(68), 20.0);
    });

    test('formats temperature strings with rounding and units', () {
      expect(TemperatureFormatter.format(21.4), '21°');
      expect(TemperatureFormatter.format(21.6), '22°');
      expect(TemperatureFormatter.format(21.4, showUnit: true), '21°C');
      expect(TemperatureFormatter.format(0, isFahrenheit: true, showUnit: true), '32°F');
    });

    test('formats high/low temperature range strings', () {
      expect(
        TemperatureFormatter.formatRange(24.2, 15.8),
        'H: 24°  L: 16°',
      );
      expect(
        TemperatureFormatter.formatRange(0, -10, isFahrenheit: true),
        'H: 32°  L: 14°',
      );
    });
  });
}
