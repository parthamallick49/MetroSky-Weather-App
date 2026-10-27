import '../entities/forecast.dart';

/// Abstract contract for fetching and caching weather forecast data.
abstract class WeatherRepository {
  /// Retrieves the complete forecast for the specified geographic coordinates.
  /// If [forceRefresh] is true, ignores local cache and forces a remote network fetch.
  Future<Forecast> getForecast({
    required double latitude,
    required double longitude,
    bool forceRefresh = false,
  });
}
