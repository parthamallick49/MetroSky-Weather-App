import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/forecast.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_local_datasource.dart';
import '../datasources/weather_remote_datasource.dart';

/// Implementation of [WeatherRepository] applying Stale-While-Revalidate (SWR) caching.
class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl({
    required WeatherRemoteDataSource remoteDataSource,
    required WeatherLocalDataSource localDataSource,
    this.cacheTtl = const Duration(minutes: 20),
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final WeatherRemoteDataSource _remoteDataSource;
  final WeatherLocalDataSource _localDataSource;
  final Duration cacheTtl;

  @override
  Future<Forecast> getForecast({
    required double latitude,
    required double longitude,
    bool forceRefresh = false,
  }) async {
    final cached = await _localDataSource.getCachedForecast(
      latitude: latitude,
      longitude: longitude,
    );

    // 1. If not forcing refresh and cached data is fresh (< 20 mins), serve immediately
    if (!forceRefresh && cached != null) {
      final cacheAge = DateTime.now().difference(cached.fetchedAt);
      if (cacheAge < cacheTtl) {
        return cached;
      }
    }

    // 2. Fetch fresh forecast from remote source
    try {
      final remoteForecast = await _remoteDataSource.getForecast(
        latitude: latitude,
        longitude: longitude,
      );

      // Save to local cache in background
      await _localDataSource.saveForecast(remoteForecast);
      return remoteForecast;
    } on AppException catch (e) {
      // 3. Graceful degradation: If network fails but stale cache exists, serve cached data
      if (cached != null) {
        return cached;
      }

      if (e is ServerException) {
        throw ServerFailure(message: e.message, statusCode: e.statusCode);
      } else if (e is NetworkException) {
        throw NetworkFailure(message: e.message, statusCode: e.statusCode);
      } else {
        throw UnknownFailure(message: e.message, statusCode: e.statusCode);
      }
    } catch (e) {
      if (cached != null) {
        return cached;
      }
      throw UnknownFailure(message: e.toString());
    }
  }
}

/// Riverpod provider for [WeatherRepository].
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  final remoteDataSource = ref.watch(weatherRemoteDataSourceProvider);
  final localDataSource = ref.watch(weatherLocalDataSourceProvider);

  return WeatherRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});
