import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/persistence/hive_storage_service.dart';
import '../../domain/entities/forecast.dart';

/// Local data source persisting forecast JSON payloads in Hive CE boxes.
abstract class WeatherLocalDataSource {
  Future<Forecast?> getCachedForecast({
    required double latitude,
    required double longitude,
  });

  Future<void> saveForecast(Forecast forecast);

  Future<void> clearCache();
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  WeatherLocalDataSourceImpl({required HiveStorageService storageService})
      : _storageService = storageService;

  final HiveStorageService _storageService;

  String _cacheKey(double lat, double lng) =>
      'forecast_${lat.toStringAsFixed(2)}_${lng.toStringAsFixed(2)}';

  @override
  Future<Forecast?> getCachedForecast({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final key = _cacheKey(latitude, longitude);
      final rawData = _storageService.weatherCacheBox.get(key);

      if (rawData == null) return null;

      final Map<String, dynamic> jsonMap;
      if (rawData is String) {
        jsonMap = json.decode(rawData) as Map<String, dynamic>;
      } else if (rawData is Map) {
        jsonMap = Map<String, dynamic>.from(rawData);
      } else {
        return null;
      }

      return Forecast.fromJson(jsonMap);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveForecast(Forecast forecast) async {
    final key = _cacheKey(forecast.latitude, forecast.longitude);
    final jsonString = json.encode(forecast.toJson());
    await _storageService.weatherCacheBox.put(key, jsonString);
  }

  @override
  Future<void> clearCache() async {
    await _storageService.weatherCacheBox.clear();
  }
}

/// Riverpod provider for [WeatherLocalDataSource].
final weatherLocalDataSourceProvider = Provider<WeatherLocalDataSource>((ref) {
  final storageService = ref.watch(hiveStorageServiceProvider);
  return WeatherLocalDataSourceImpl(storageService: storageService);
});
