import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_preferences.freezed.dart';
part 'user_preferences.g.dart';

enum TemperatureUnit {
  celsius,
  fahrenheit;

  String get symbol => this == TemperatureUnit.celsius ? '°C' : '°F';
  String get label => this == TemperatureUnit.celsius ? 'Celsius (°C)' : 'Fahrenheit (°F)';
}

enum WindSpeedUnit {
  kmh,
  mph,
  ms;

  String get symbol {
    switch (this) {
      case WindSpeedUnit.kmh:
        return 'km/h';
      case WindSpeedUnit.mph:
        return 'mph';
      case WindSpeedUnit.ms:
        return 'm/s';
    }
  }

  String get label {
    switch (this) {
      case WindSpeedUnit.kmh:
        return 'Kilometers per hour (km/h)';
      case WindSpeedUnit.mph:
        return 'Miles per hour (mph)';
      case WindSpeedUnit.ms:
        return 'Meters per second (m/s)';
    }
  }
}

enum PressureUnit {
  hPa,
  inHg;

  String get symbol => this == PressureUnit.hPa ? 'hPa' : 'inHg';
  String get label => this == PressureUnit.hPa ? 'Hectopascals (hPa)' : 'Inches of Mercury (inHg)';
}

enum PrecipitationUnit {
  mm,
  inches;

  String get symbol => this == PrecipitationUnit.mm ? 'mm' : 'in';
  String get label => this == PrecipitationUnit.mm ? 'Millimeters (mm)' : 'Inches (in)';
}

/// Immutable user preferences entity.
@freezed
abstract class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    @Default(TemperatureUnit.celsius) TemperatureUnit temperatureUnit,
    @Default(WindSpeedUnit.kmh) WindSpeedUnit windSpeedUnit,
    @Default(PressureUnit.hPa) PressureUnit pressureUnit,
    @Default(PrecipitationUnit.mm) PrecipitationUnit precipitationUnit,
    @Default(true) bool enableShaders,
    @Default(true) bool enableParticles,
    @Default(true) bool enableHaptics,
  }) = _UserPreferences;

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
}
