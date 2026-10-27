import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/weather_repository_impl.dart';
import '../../domain/entities/forecast.dart';

/// Active coordinate state: default is London (51.5074° N, 0.1278° W) until GPS updates.
class WeatherLocationParams {
  const WeatherLocationParams({
    required this.latitude,
    required this.longitude,
    this.cityName = 'Current Location',
  });

  final double latitude;
  final double longitude;
  final String cityName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherLocationParams &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude;

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}

/// Provider managing active weather coordinates and city label.
final activeWeatherLocationProvider = StateProvider<WeatherLocationParams>((ref) {
  return const WeatherLocationParams(
    latitude: 51.5074,
    longitude: -0.1278,
    cityName: 'London',
  );
});

/// Riverpod AsyncNotifier managing the state and refresh lifecycle of [Forecast].
class WeatherController extends AsyncNotifier<Forecast> {
  @override
  FutureOr<Forecast> build() async {
    final location = ref.watch(activeWeatherLocationProvider);
    final repository = ref.watch(weatherRepositoryProvider);

    return repository.getForecast(
      latitude: location.latitude,
      longitude: location.longitude,
    );
  }

  /// Forces a fresh remote fetch, bypassing local Hive cache.
  Future<void> refresh() async {
    final location = ref.read(activeWeatherLocationProvider);
    final repository = ref.read(weatherRepositoryProvider);

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return repository.getForecast(
        latitude: location.latitude,
        longitude: location.longitude,
        forceRefresh: true,
      );
    });
  }

  /// Updates active coordinates and triggers reactive refetch.
  void setLocation({
    required double latitude,
    required double longitude,
    required String cityName,
  }) {
    ref.read(activeWeatherLocationProvider.notifier).state =
        WeatherLocationParams(
      latitude: latitude,
      longitude: longitude,
      cityName: cityName,
    );
  }
}

/// Global provider for [WeatherController].
final weatherControllerProvider =
    AsyncNotifierProvider<WeatherController, Forecast>(WeatherController.new);
