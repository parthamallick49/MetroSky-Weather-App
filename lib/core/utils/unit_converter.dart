import '../../features/settings/domain/entities/user_preferences.dart';
import 'temperature_formatter.dart';

/// Pure global utility for multi-unit conversion and formatting across the app.
class UnitConverter {
  UnitConverter._();

  /// Converts Celsius temperature to target [TemperatureUnit].
  static double convertTemperature(double celsius, TemperatureUnit unit) {
    if (unit == TemperatureUnit.fahrenheit) {
      return TemperatureFormatter.toFahrenheit(celsius);
    }
    return celsius;
  }

  /// Formats temperature with target unit symbol or degree sign.
  static String formatTemperature(
    double celsius,
    TemperatureUnit unit, {
    bool showUnit = false,
  }) {
    return TemperatureFormatter.format(
      celsius,
      isFahrenheit: unit == TemperatureUnit.fahrenheit,
      showUnit: showUnit,
    );
  }

  /// Converts wind speed from km/h (Open-Meteo baseline) to target [WindSpeedUnit].
  static double convertWindSpeed(double kmh, WindSpeedUnit unit) {
    switch (unit) {
      case WindSpeedUnit.kmh:
        return kmh;
      case WindSpeedUnit.mph:
        return kmh * 0.62137119;
      case WindSpeedUnit.ms:
        return kmh / 3.6;
    }
  }

  /// Formats wind speed with rounded value and unit symbol (e.g. "18 km/h").
  static String formatWindSpeed(double kmh, WindSpeedUnit unit) {
    final value = convertWindSpeed(kmh, unit);
    return '${value.toStringAsFixed(1)} ${unit.symbol}';
  }

  /// Converts pressure from hPa to target [PressureUnit].
  static double convertPressure(double hPa, PressureUnit unit) {
    switch (unit) {
      case PressureUnit.hPa:
        return hPa;
      case PressureUnit.inHg:
        return hPa * 0.029529983;
    }
  }

  /// Formats atmospheric pressure with appropriate precision.
  static String formatPressure(double hPa, PressureUnit unit) {
    final value = convertPressure(hPa, unit);
    if (unit == PressureUnit.inHg) {
      return '${value.toStringAsFixed(2)} ${unit.symbol}';
    }
    return '${value.round()} ${unit.symbol}';
  }

  /// Converts precipitation from mm to target [PrecipitationUnit].
  static double convertPrecipitation(double mm, PrecipitationUnit unit) {
    switch (unit) {
      case PrecipitationUnit.mm:
        return mm;
      case PrecipitationUnit.inches:
        return mm * 0.0393700787;
    }
  }

  /// Formats precipitation with unit symbol (e.g. "2.4 mm" or "0.10 in").
  static String formatPrecipitation(double mm, PrecipitationUnit unit) {
    final value = convertPrecipitation(mm, unit);
    if (unit == PrecipitationUnit.inches) {
      return '${value.toStringAsFixed(2)} ${unit.symbol}';
    }
    return '${value.toStringAsFixed(1)} ${unit.symbol}';
  }
}
