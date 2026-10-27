import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/constants/wmo_weather_codes.dart';
import 'package:weather_app/features/weather/data/models/open_meteo_air_quality_response.dart';
import 'package:weather_app/features/weather/data/models/open_meteo_forecast_response.dart';

void main() {
  group('OpenMeteo Parsing', () {
    test('parses columnar forecast response into structured domain models', () {
      final json = {
        'latitude': 51.5074,
        'longitude': -0.1278,
        'timezone': 'Europe/London',
        'current': {
          'time': '2026-10-27T12:00',
          'temperature_2m': 16.4,
          'apparent_temperature': 15.2,
          'relative_humidity_2m': 68,
          'surface_pressure': 1016.5,
          'wind_speed_10m': 14.2,
          'wind_direction_10m': 210.0,
          'precipitation': 0.0,
          'weather_code': 2,
          'is_day': 1,
        },
        'hourly': {
          'time': ['2026-10-27T12:00', '2026-10-27T13:00'],
          'temperature_2m': [16.4, 17.1],
          'relative_humidity_2m': [68, 64],
          'dew_point_2m': [10.2, 10.0],
          'precipitation_probability': [10, 20],
          'precipitation': [0.0, 0.1],
          'weather_code': [2, 3],
          'surface_pressure': [1016.5, 1016.2],
          'visibility': [10000.0, 9500.0],
          'wind_speed_10m': [14.2, 15.0],
          'uv_index': [3.2, 2.8],
        },
        'daily': {
          'time': ['2026-10-27'],
          'weather_code': [2],
          'temperature_2m_max': [18.5],
          'temperature_2m_min': [11.2],
          'sunrise': ['2026-10-27T06:50'],
          'sunset': ['2026-10-27T17:45'],
          'uv_index_max': [3.5],
          'precipitation_sum': [0.5],
          'precipitation_probability_max': [30],
        },
      };

      final response = OpenMeteoForecastResponse.fromJson(json);

      expect(response.latitude, 51.5074);
      expect(response.longitude, -0.1278);
      expect(response.timezone, 'Europe/London');

      // Current
      expect(response.current.temperature, 16.4);
      expect(response.current.isDay, isTrue);
      expect(response.current.conditionText, 'Partly Cloudy');
      expect(response.current.category, WeatherConditionCategory.partlyCloudy);

      // Hourly
      expect(response.hourly.length, 2);
      expect(response.hourly.first.temperature, 16.4);
      expect(response.hourly.last.precipitationProbability, 20);

      // Daily
      expect(response.daily.length, 1);
      expect(response.daily.first.maxTemperature, 18.5);
      expect(response.daily.first.minTemperature, 11.2);
    });

    test('parses air quality response accurately', () {
      final json = {
        'latitude': 51.5074,
        'longitude': -0.1278,
        'current': {
          'european_aqi': 25,
          'us_aqi': 42,
          'pm10': 12.0,
          'pm2_5': 7.5,
          'carbon_monoxide': 220.0,
          'nitrogen_dioxide': 19.4,
          'sulphur_dioxide': 2.3,
          'ozone': 38.0,
        },
      };

      final response = OpenMeteoAirQualityResponse.fromJson(json);
      expect(response.airQuality.usAqi, 42);
      expect(response.airQuality.statusText, 'Good');
    });
  });
}
