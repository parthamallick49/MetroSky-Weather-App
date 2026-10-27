import '../../domain/entities/current_weather.dart';
import '../../domain/entities/daily_forecast.dart';
import '../../domain/entities/hourly_weather.dart';

/// DTO parser transforming Open-Meteo's columnar JSON response into domain models.
class OpenMeteoForecastResponse {
  OpenMeteoForecastResponse({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.current,
    required this.hourly,
    required this.daily,
  });

  factory OpenMeteoForecastResponse.fromJson(Map<String, dynamic> json) {
    final currentJson = json['current'] as Map<String, dynamic>? ?? {};
    final hourlyJson = json['hourly'] as Map<String, dynamic>? ?? {};
    final dailyJson = json['daily'] as Map<String, dynamic>? ?? {};

    // 1. Parse Current Weather
    final current = CurrentWeather(
      temperature: (currentJson['temperature_2m'] as num?)?.toDouble() ?? 0.0,
      apparentTemperature:
          (currentJson['apparent_temperature'] as num?)?.toDouble() ?? 0.0,
      relativeHumidity: (currentJson['relative_humidity_2m'] as num?)?.toInt() ?? 0,
      surfacePressure:
          (currentJson['surface_pressure'] as num?)?.toDouble() ?? 1013.25,
      windSpeed: (currentJson['wind_speed_10m'] as num?)?.toDouble() ?? 0.0,
      windDirection:
          (currentJson['wind_direction_10m'] as num?)?.toDouble() ?? 0.0,
      precipitation: (currentJson['precipitation'] as num?)?.toDouble() ?? 0.0,
      weatherCode: (currentJson['weather_code'] as num?)?.toInt() ?? 0,
      isDay: (currentJson['is_day'] as num?)?.toInt() == 1,
      time: DateTime.tryParse(currentJson['time']?.toString() ?? '') ??
          DateTime.now(),
    );

    // 2. Parse Columnar Hourly Array into List<HourlyWeather>
    final hourlyTimes = (hourlyJson['time'] as List<dynamic>?) ?? [];
    final hourlyTemps = (hourlyJson['temperature_2m'] as List<dynamic>?) ?? [];
    final hourlyHumidities =
        (hourlyJson['relative_humidity_2m'] as List<dynamic>?) ?? [];
    final hourlyDewPoints = (hourlyJson['dew_point_2m'] as List<dynamic>?) ?? [];
    final hourlyPrecipProbs =
        (hourlyJson['precipitation_probability'] as List<dynamic>?) ?? [];
    final hourlyPrecips = (hourlyJson['precipitation'] as List<dynamic>?) ?? [];
    final hourlyCodes = (hourlyJson['weather_code'] as List<dynamic>?) ?? [];
    final hourlyPressures =
        (hourlyJson['surface_pressure'] as List<dynamic>?) ?? [];
    final hourlyVisibilities =
        (hourlyJson['visibility'] as List<dynamic>?) ?? [];
    final hourlyWinds = (hourlyJson['wind_speed_10m'] as List<dynamic>?) ?? [];
    final hourlyUvs = (hourlyJson['uv_index'] as List<dynamic>?) ?? [];

    final hourlyCount = hourlyTimes.length;
    final hourlyList = <HourlyWeather>[];

    for (var i = 0; i < hourlyCount; i++) {
      final timeStr = hourlyTimes[i]?.toString() ?? '';
      final parsedTime = DateTime.tryParse(timeStr) ?? DateTime.now();

      // Estimate daytime for hourly entry (6 AM to 8 PM or using current isDay)
      final hourOfDay = parsedTime.hour;
      final isDayTime = hourOfDay >= 6 && hourOfDay < 20;

      hourlyList.add(
        HourlyWeather(
          time: parsedTime,
          temperature: (hourlyTemps.elementAtOrNull(i) as num?)?.toDouble() ?? 0.0,
          relativeHumidity:
              (hourlyHumidities.elementAtOrNull(i) as num?)?.toInt() ?? 0,
          dewPoint:
              (hourlyDewPoints.elementAtOrNull(i) as num?)?.toDouble() ?? 0.0,
          precipitationProbability:
              (hourlyPrecipProbs.elementAtOrNull(i) as num?)?.toInt() ?? 0,
          precipitation:
              (hourlyPrecips.elementAtOrNull(i) as num?)?.toDouble() ?? 0.0,
          weatherCode: (hourlyCodes.elementAtOrNull(i) as num?)?.toInt() ?? 0,
          surfacePressure:
              (hourlyPressures.elementAtOrNull(i) as num?)?.toDouble() ?? 1013.25,
          visibility:
              (hourlyVisibilities.elementAtOrNull(i) as num?)?.toDouble() ?? 10000.0,
          windSpeed: (hourlyWinds.elementAtOrNull(i) as num?)?.toDouble() ?? 0.0,
          uvIndex: (hourlyUvs.elementAtOrNull(i) as num?)?.toDouble() ?? 0.0,
          isDay: isDayTime,
        ),
      );
    }

    // 3. Parse Columnar Daily Array into List<DailyForecast>
    final dailyTimes = (dailyJson['time'] as List<dynamic>?) ?? [];
    final dailyCodes = (dailyJson['weather_code'] as List<dynamic>?) ?? [];
    final dailyMaxTemps =
        (dailyJson['temperature_2m_max'] as List<dynamic>?) ?? [];
    final dailyMinTemps =
        (dailyJson['temperature_2m_min'] as List<dynamic>?) ?? [];
    final dailySunrises = (dailyJson['sunrise'] as List<dynamic>?) ?? [];
    final dailySunsets = (dailyJson['sunset'] as List<dynamic>?) ?? [];
    final dailyMaxUvs = (dailyJson['uv_index_max'] as List<dynamic>?) ?? [];
    final dailyPrecipSums =
        (dailyJson['precipitation_sum'] as List<dynamic>?) ?? [];
    final dailyPrecipProbMaxes =
        (dailyJson['precipitation_probability_max'] as List<dynamic>?) ?? [];

    final dailyCount = dailyTimes.length;
    final dailyList = <DailyForecast>[];

    for (var i = 0; i < dailyCount; i++) {
      dailyList.add(
        DailyForecast(
          date: DateTime.tryParse(dailyTimes[i]?.toString() ?? '') ??
              DateTime.now(),
          maxTemperature:
              (dailyMaxTemps.elementAtOrNull(i) as num?)?.toDouble() ?? 0.0,
          minTemperature:
              (dailyMinTemps.elementAtOrNull(i) as num?)?.toDouble() ?? 0.0,
          weatherCode: (dailyCodes.elementAtOrNull(i) as num?)?.toInt() ?? 0,
          sunrise: DateTime.tryParse(dailySunrises.elementAtOrNull(i)?.toString() ?? '') ??
              DateTime.now(),
          sunset: DateTime.tryParse(dailySunsets.elementAtOrNull(i)?.toString() ?? '') ??
              DateTime.now(),
          uvIndexMax: (dailyMaxUvs.elementAtOrNull(i) as num?)?.toDouble() ?? 0.0,
          precipitationSum:
              (dailyPrecipSums.elementAtOrNull(i) as num?)?.toDouble() ?? 0.0,
          precipitationProbabilityMax:
              (dailyPrecipProbMaxes.elementAtOrNull(i) as num?)?.toInt() ?? 0,
        ),
      );
    }

    return OpenMeteoForecastResponse(
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      timezone: json['timezone']?.toString() ?? 'UTC',
      current: current,
      hourly: hourlyList,
      daily: dailyList,
    );
  }

  final double latitude;
  final double longitude;
  final String timezone;
  final CurrentWeather current;
  final List<HourlyWeather> hourly;
  final List<DailyForecast> daily;
}
