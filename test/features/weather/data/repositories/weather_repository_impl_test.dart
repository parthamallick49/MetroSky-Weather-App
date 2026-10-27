import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/features/weather/data/datasources/weather_local_datasource.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/entities/air_quality.dart';
import 'package:weather_app/features/weather/domain/entities/current_weather.dart';
import 'package:weather_app/features/weather/domain/entities/forecast.dart';

class MockRemoteDataSource implements WeatherRemoteDataSource {
  MockRemoteDataSource({this.shouldThrow = false});

  bool shouldThrow;
  int callCount = 0;

  @override
  Future<Forecast> getForecast({
    required double latitude,
    required double longitude,
  }) async {
    callCount++;
    if (shouldThrow) {
      throw const NetworkException(message: 'Connection failed');
    }
    return Forecast(
      latitude: latitude,
      longitude: longitude,
      timezone: 'UTC',
      current: CurrentWeather(
        temperature: 20.0,
        apparentTemperature: 19.0,
        relativeHumidity: 50,
        surfacePressure: 1013.0,
        windSpeed: 10.0,
        windDirection: 180.0,
        precipitation: 0.0,
        weatherCode: 0,
        isDay: true,
        time: DateTime.now(),
      ),
      hourly: [],
      daily: [],
      airQuality: const AirQuality(
        europeanAqi: 20,
        usAqi: 30,
        pm10: 10.0,
        pm25: 5.0,
        carbonMonoxide: 200.0,
        nitrogenDioxide: 10.0,
        sulphurDioxide: 2.0,
        ozone: 30.0,
      ),
      fetchedAt: DateTime.now(),
    );
  }
}

class MockLocalDataSource implements WeatherLocalDataSource {
  Forecast? cachedForecast;
  int saveCount = 0;

  @override
  Future<Forecast?> getCachedForecast({
    required double latitude,
    required double longitude,
  }) async {
    return cachedForecast;
  }

  @override
  Future<void> saveForecast(Forecast forecast) async {
    saveCount++;
    cachedForecast = forecast;
  }

  @override
  Future<void> clearCache() async {
    cachedForecast = null;
  }
}

void main() {
  group('WeatherRepositoryImpl (SWR Caching)', () {
    late MockRemoteDataSource remoteDataSource;
    late MockLocalDataSource localDataSource;
    late WeatherRepositoryImpl repository;

    setUp(() {
      remoteDataSource = MockRemoteDataSource();
      localDataSource = MockLocalDataSource();
      repository = WeatherRepositoryImpl(
        remoteDataSource: remoteDataSource,
        localDataSource: localDataSource,
        cacheTtl: const Duration(minutes: 20),
      );
    });

    test('serves cached data immediately when cache is fresh', () async {
      final freshCache = Forecast(
        latitude: 51.5,
        longitude: -0.1,
        timezone: 'UTC',
        current: CurrentWeather(
          temperature: 15.0,
          apparentTemperature: 14.0,
          relativeHumidity: 60,
          surfacePressure: 1015.0,
          windSpeed: 5.0,
          windDirection: 90.0,
          precipitation: 0.0,
          weatherCode: 1,
          isDay: true,
          time: DateTime.now(),
        ),
        hourly: [],
        daily: [],
        airQuality: const AirQuality(
          europeanAqi: 15,
          usAqi: 25,
          pm10: 8.0,
          pm25: 4.0,
          carbonMonoxide: 180.0,
          nitrogenDioxide: 8.0,
          sulphurDioxide: 1.5,
          ozone: 25.0,
        ),
        fetchedAt: DateTime.now().subtract(const Duration(minutes: 5)),
      );

      localDataSource.cachedForecast = freshCache;

      final result = await repository.getForecast(latitude: 51.5, longitude: -0.1);

      expect(result.current.temperature, 15.0);
      expect(remoteDataSource.callCount, 0); // Remote fetch skipped
    });

    test('fetches remote when cache is stale (> 20 min) and updates local cache', () async {
      final staleCache = Forecast(
        latitude: 51.5,
        longitude: -0.1,
        timezone: 'UTC',
        current: CurrentWeather(
          temperature: 10.0,
          apparentTemperature: 9.0,
          relativeHumidity: 70,
          surfacePressure: 1010.0,
          windSpeed: 15.0,
          windDirection: 270.0,
          precipitation: 1.0,
          weatherCode: 61,
          isDay: true,
          time: DateTime.now(),
        ),
        hourly: [],
        daily: [],
        airQuality: const AirQuality(
          europeanAqi: 30,
          usAqi: 45,
          pm10: 15.0,
          pm25: 8.0,
          carbonMonoxide: 250.0,
          nitrogenDioxide: 15.0,
          sulphurDioxide: 3.0,
          ozone: 35.0,
        ),
        fetchedAt: DateTime.now().subtract(const Duration(minutes: 30)),
      );

      localDataSource.cachedForecast = staleCache;

      final result = await repository.getForecast(latitude: 51.5, longitude: -0.1);

      expect(result.current.temperature, 20.0); // Got fresh data from remote
      expect(remoteDataSource.callCount, 1);
      expect(localDataSource.saveCount, 1);
    });

    test('falls back gracefully to stale cache when remote fetch fails', () async {
      final staleCache = Forecast(
        latitude: 51.5,
        longitude: -0.1,
        timezone: 'UTC',
        current: CurrentWeather(
          temperature: 12.0,
          apparentTemperature: 11.0,
          relativeHumidity: 65,
          surfacePressure: 1012.0,
          windSpeed: 8.0,
          windDirection: 180.0,
          precipitation: 0.0,
          weatherCode: 2,
          isDay: true,
          time: DateTime.now(),
        ),
        hourly: [],
        daily: [],
        airQuality: const AirQuality(
          europeanAqi: 20,
          usAqi: 30,
          pm10: 10.0,
          pm25: 5.0,
          carbonMonoxide: 200.0,
          nitrogenDioxide: 10.0,
          sulphurDioxide: 2.0,
          ozone: 30.0,
        ),
        fetchedAt: DateTime.now().subtract(const Duration(hours: 2)),
      );

      localDataSource.cachedForecast = staleCache;
      remoteDataSource.shouldThrow = true;

      final result = await repository.getForecast(latitude: 51.5, longitude: -0.1);

      expect(result.current.temperature, 12.0); // Degrades gracefully to cached data
      expect(remoteDataSource.callCount, 1);
    });
  });
}
