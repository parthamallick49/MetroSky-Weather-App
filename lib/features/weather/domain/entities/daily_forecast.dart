import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/constants/wmo_weather_codes.dart';

part 'daily_forecast.freezed.dart';
part 'daily_forecast.g.dart';

/// Immutable domain model representing a single day in the weekly forecast.
@freezed
class DailyForecast with _$DailyForecast {
  const DailyForecast._();

  const factory DailyForecast({
    required DateTime date,
    required double maxTemperature,
    required double minTemperature,
    required int weatherCode,
    required DateTime sunrise,
    required DateTime sunset,
    required double uvIndexMax,
    required double precipitationSum,
    required int precipitationProbabilityMax,
  }) = _DailyForecast;

  factory DailyForecast.fromJson(Map<String, dynamic> json) =>
      _$DailyForecastFromJson(json);

  /// Human-readable condition description from WMO code.
  String get conditionText => WmoWeatherCode.getDescription(weatherCode);

  /// Animation asset path (always uses day asset for daily summary).
  String get animationAsset =>
      WmoWeatherCode.getAnimationAsset(weatherCode, isDay: true);
}
