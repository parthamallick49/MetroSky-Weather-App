import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/forecast.dart';
import '../models/open_meteo_air_quality_response.dart';
import '../models/open_meteo_forecast_response.dart';

/// Remote data source calling Open-Meteo Forecast and Air Quality endpoints.
abstract class WeatherRemoteDataSource {
  Future<Forecast> getForecast({
    required double latitude,
    required double longitude,
  });
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  WeatherRemoteDataSourceImpl({required DioClient dioClient})
      : _dioClient = dioClient;

  final DioClient _dioClient;

  @override
  Future<Forecast> getForecast({
    required double latitude,
    required double longitude,
  }) async {
    final forecastParams = <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'current':
          'temperature_2m,relative_humidity_2m,apparent_temperature,is_day,precipitation,rain,weather_code,surface_pressure,wind_speed_10m,wind_direction_10m',
      'hourly':
          'temperature_2m,relative_humidity_2m,dew_point_2m,precipitation_probability,precipitation,weather_code,surface_pressure,visibility,wind_speed_10m,uv_index',
      'daily':
          'weather_code,temperature_2m_max,temperature_2m_min,sunrise,sunset,uv_index_max,precipitation_sum,precipitation_probability_max',
      'timezone': 'auto',
    };

    final airQualityParams = <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'current':
          'european_aqi,us_aqi,pm10,pm2_5,carbon_monoxide,nitrogen_dioxide,sulphur_dioxide,ozone',
      'timezone': 'auto',
    };

    // Execute forecast and air quality requests concurrently
    final responses = await Future.wait([
      _dioClient.get<Map<String, dynamic>>(
        '${ApiEndpoints.openMeteoForecastBaseUrl}/forecast',
        queryParameters: forecastParams,
      ),
      _dioClient.get<Map<String, dynamic>>(
        '${ApiEndpoints.openMeteoAirQualityBaseUrl}/air-quality',
        queryParameters: airQualityParams,
      ),
    ]);

    final forecastResponse = OpenMeteoForecastResponse.fromJson(
      responses[0].data ?? {},
    );
    final aqiResponse = OpenMeteoAirQualityResponse.fromJson(
      responses[1].data ?? {},
    );

    return Forecast(
      latitude: forecastResponse.latitude,
      longitude: forecastResponse.longitude,
      timezone: forecastResponse.timezone,
      current: forecastResponse.current,
      hourly: forecastResponse.hourly,
      daily: forecastResponse.daily,
      airQuality: aqiResponse.airQuality,
      fetchedAt: DateTime.now(),
    );
  }
}

/// Riverpod provider for [WeatherRemoteDataSource].
final weatherRemoteDataSourceProvider = Provider<WeatherRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return WeatherRemoteDataSourceImpl(dioClient: dioClient);
});
