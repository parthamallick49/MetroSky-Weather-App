import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/constants/wmo_weather_codes.dart';

part 'hourly_weather.freezed.dart';
part 'hourly_weather.g.dart';

/// Immutable domain model representing a single hour in the forecast timeline.
@freezed
class HourlyWeather with _$HourlyWeather {
  const HourlyWeather._();

  const factory HourlyWeather({
    required DateTime time,
    required double temperature,
    required int relativeHumidity,
    required double dewPoint,
    required int precipitationProbability,
    required double precipitation,
    required int weatherCode,
    required double surfacePressure,
    required double visibility,
    required double windSpeed,
    required double uvIndex,
    required bool isDay,
  }) = _HourlyWeather;

  factory HourlyWeather.fromJson(Map<String, dynamic> json) =>
      _$HourlyWeatherFromJson(json);

  /// Human-readable condition description from WMO code.
  String get conditionText => WmoWeatherCode.getDescription(weatherCode);

  /// Animation asset path.
  String get animationAsset =>
      WmoWeatherCode.getAnimationAsset(weatherCode, isDay: isDay);
}
