import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/constants/wmo_weather_codes.dart';

part 'current_weather.freezed.dart';
part 'current_weather.g.dart';

/// Immutable domain model representing current live weather conditions.
@freezed
class CurrentWeather with _$CurrentWeather {
  const CurrentWeather._();

  const factory CurrentWeather({
    required double temperature,
    required double apparentTemperature,
    required int relativeHumidity,
    required double surfacePressure,
    required double windSpeed,
    required double windDirection,
    required double precipitation,
    required int weatherCode,
    required bool isDay,
    required DateTime time,
  }) = _CurrentWeather;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);

  /// Human-readable condition description from WMO code.
  String get conditionText => WmoWeatherCode.getDescription(weatherCode);

  /// High-level condition category enum.
  WeatherConditionCategory get category => WmoWeatherCode.getCategory(weatherCode);

  /// Animation asset path.
  String get animationAsset =>
      WmoWeatherCode.getAnimationAsset(weatherCode, isDay: isDay);
}
