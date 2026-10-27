import 'package:freezed_annotation/freezed_annotation.dart';

part 'air_quality.freezed.dart';
part 'air_quality.g.dart';

/// Categories for European and US Air Quality Index (AQI).
enum AqiLevel {
  good,
  fair,
  moderate,
  poor,
  veryPoor,
  hazardous,
}

/// Immutable domain model representing air quality and pollutant concentrations.
@freezed
class AirQuality with _$AirQuality {
  const AirQuality._();

  const factory AirQuality({
    required int europeanAqi,
    required int usAqi,
    required double pm10,
    required double pm25,
    required double carbonMonoxide,
    required double nitrogenDioxide,
    required double sulphurDioxide,
    required double ozone,
  }) = _AirQuality;

  factory AirQuality.fromJson(Map<String, dynamic> json) =>
      _$AirQualityFromJson(json);

  /// Qualitative classification of the US AQI index (0-500 scale).
  AqiLevel get level {
    if (usAqi <= 50) return AqiLevel.good;
    if (usAqi <= 100) return AqiLevel.fair;
    if (usAqi <= 150) return AqiLevel.moderate;
    if (usAqi <= 200) return AqiLevel.poor;
    if (usAqi <= 300) return AqiLevel.veryPoor;
    return AqiLevel.hazardous;
  }

  /// Human-readable description of current air quality status.
  String get statusText {
    switch (level) {
      case AqiLevel.good:
        return 'Good';
      case AqiLevel.fair:
        return 'Moderate';
      case AqiLevel.moderate:
        return 'Unhealthy for Sensitive Groups';
      case AqiLevel.poor:
        return 'Unhealthy';
      case AqiLevel.veryPoor:
        return 'Very Unhealthy';
      case AqiLevel.hazardous:
        return 'Hazardous';
    }
  }
}
