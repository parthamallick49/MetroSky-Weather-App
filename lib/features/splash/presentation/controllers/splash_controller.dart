import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../location/data/repositories/location_repository_impl.dart';
import '../../../weather/presentation/controllers/weather_controller.dart';

enum SplashStatus {
  initializing,
  completed,
}

/// Riverpod AsyncNotifier orchestrating splash bootstrapping, GPS retrieval, and prefetching.
class SplashController extends AsyncNotifier<SplashStatus> {
  @override
  FutureOr<SplashStatus> build() async {
    return SplashStatus.initializing;
  }

  /// Initializes device location, reverse geocodes the real city name, and warms cache.
  Future<void> initializeApp({Duration minDisplayDuration = const Duration(milliseconds: 1500)}) async {
    final startTime = DateTime.now();

    try {
      final locationRepository = ref.read(locationRepositoryProvider);

      try {
        // 1. Attempt to fetch device GPS location with reverse geocoded city name
        final deviceLocation = await locationRepository.getCurrentDeviceLocation().timeout(
              const Duration(seconds: 4),
            );

        ref.read(activeWeatherLocationProvider.notifier).state = WeatherLocationParams(
          latitude: deviceLocation.latitude,
          longitude: deviceLocation.longitude,
          cityName: deviceLocation.name,
        );
      } catch (_) {
        // 2. GPS unavailable or denied - fallback to user's saved favorite location if any
        final savedLocations = await locationRepository.getSavedLocations();
        if (savedLocations.isNotEmpty) {
          final first = savedLocations.first;
          ref.read(activeWeatherLocationProvider.notifier).state = WeatherLocationParams(
            latitude: first.latitude,
            longitude: first.longitude,
            cityName: first.name,
          );
        }
      }

      // 3. Trigger initial forecast fetch for active location
      // (Reading weatherControllerProvider initializes its build() method)
      ref.read(weatherControllerProvider);
    } finally {
      // 4. Guarantee minimum visual branding presentation duration
      final elapsed = DateTime.now().difference(startTime);
      if (elapsed < minDisplayDuration) {
        await Future.delayed(minDisplayDuration - elapsed);
      }

      state = const AsyncValue.data(SplashStatus.completed);
    }
  }
}

/// Global provider for [SplashController].
final splashControllerProvider =
    AsyncNotifierProvider<SplashController, SplashStatus>(
  SplashController.new,
);
