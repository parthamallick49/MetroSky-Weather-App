import 'package:freezed_annotation/freezed_annotation.dart';
import 'air_quality.dart';
import 'current_weather.dart';
import 'daily_forecast.dart';
import 'hourly_weather.dart';

part 'forecast.freezed.dart';
part 'forecast.g.dart';

/// Complete meteorological forecast entity combining live, hourly, daily, and AQI data.
@freezed
class Forecast with _$Forecast {
  const factory Forecast({
    required double latitude,
    required double longitude,
    required String timezone,
    required CurrentWeather current,
    required List<HourlyWeather> hourly,
    required List<DailyForecast> daily,
    required AirQuality airQuality,
    required DateTime fetchedAt,
  }) = _Forecast;

  factory Forecast.fromJson(Map<String, dynamic> json) =>
      _$ForecastFromJson(json);
}
