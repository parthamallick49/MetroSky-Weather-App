import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/utils/unit_converter.dart';
import 'package:weather_app/features/settings/domain/entities/user_preferences.dart';

void main() {
  group('UnitConverter', () {
    test('converts temperatures properly between Celsius and Fahrenheit', () {
      expect(UnitConverter.convertTemperature(0.0, TemperatureUnit.celsius), 0.0);
      expect(UnitConverter.convertTemperature(100.0, TemperatureUnit.celsius), 100.0);
      expect(UnitConverter.convertTemperature(0.0, TemperatureUnit.fahrenheit), 32.0);
      expect(UnitConverter.convertTemperature(100.0, TemperatureUnit.fahrenheit), 212.0);

      expect(UnitConverter.formatTemperature(20.4, TemperatureUnit.celsius), '20°');
      expect(UnitConverter.formatTemperature(20.4, TemperatureUnit.fahrenheit), '69°');
    });

    test('converts wind speed between km/h, mph, and m/s', () {
      expect(UnitConverter.convertWindSpeed(36.0, WindSpeedUnit.kmh), 36.0);
      expect(UnitConverter.convertWindSpeed(36.0, WindSpeedUnit.ms), 10.0);
      expect(UnitConverter.convertWindSpeed(100.0, WindSpeedUnit.mph), closeTo(62.137, 0.01));

      expect(UnitConverter.formatWindSpeed(18.5, WindSpeedUnit.kmh), '18.5 km/h');
      expect(UnitConverter.formatWindSpeed(36.0, WindSpeedUnit.ms), '10.0 m/s');
    });

    test('converts pressure between hPa and inHg', () {
      expect(UnitConverter.convertPressure(1013.25, PressureUnit.hPa), 1013.25);
      expect(UnitConverter.convertPressure(1013.25, PressureUnit.inHg), closeTo(29.92, 0.01));

      expect(UnitConverter.formatPressure(1013.25, PressureUnit.hPa), '1013 hPa');
      expect(UnitConverter.formatPressure(1013.25, PressureUnit.inHg), '29.92 inHg');
    });

    test('converts precipitation between mm and inches', () {
      expect(UnitConverter.convertPrecipitation(25.4, PrecipitationUnit.mm), 25.4);
      expect(UnitConverter.convertPrecipitation(25.4, PrecipitationUnit.inches), closeTo(1.0, 0.01));

      expect(UnitConverter.formatPrecipitation(12.3, PrecipitationUnit.mm), '12.3 mm');
      expect(UnitConverter.formatPrecipitation(25.4, PrecipitationUnit.inches), '1.00 in');
    });
  });
}
