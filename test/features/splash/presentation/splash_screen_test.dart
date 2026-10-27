import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/features/location/data/repositories/location_repository_impl.dart';
import 'package:weather_app/features/location/domain/entities/location_item.dart';
import 'package:weather_app/features/location/domain/repositories/location_repository.dart';
import 'package:weather_app/features/splash/presentation/controllers/splash_controller.dart';
import 'package:weather_app/features/splash/presentation/widgets/splash_screen.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/entities/air_quality.dart';
import 'package:weather_app/features/weather/domain/entities/current_weather.dart';
import 'package:weather_app/features/weather/domain/entities/forecast.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/features/weather/presentation/controllers/weather_controller.dart';

class FakeLocationRepository implements LocationRepository {
  @override
  Future<LocationItem> getCurrentDeviceLocation() async {
    return const LocationItem(
      name: 'Sydney',
      country: 'Australia',
      latitude: -33.8688,
      longitude: 151.2093,
      isCurrentLocation: true,
    );
  }

  @override
  Future<List<LocationItem>> getSavedLocations() async => [];

  @override
  Future<void> saveLocation(LocationItem location) async {}

  @override
  Future<void> deleteLocation(LocationItem location) async {}

  @override
  Future<void> reorderLocations(int oldIndex, int newIndex) async {}

  @override
  Future<List<LocationItem>> searchCities(String query) async => [];
}

class FakeWeatherRepository implements WeatherRepository {
  @override
  Future<Forecast> getForecast({
    required double latitude,
    required double longitude,
    bool forceRefresh = false,
  }) async {
    return Forecast(
      latitude: latitude,
      longitude: longitude,
      timezone: 'UTC',
      current: CurrentWeather(
        temperature: 20.0,
        apparentTemperature: 20.0,
        relativeHumidity: 50,
        surfacePressure: 1013.0,
        windSpeed: 10.0,
        windDirection: 180.0,
        precipitation: 0.0,
        weatherCode: 0,
        isDay: true,
        time: DateTime.now(),
      ),
      hourly: const [],
      daily: const [],
      airQuality: const AirQuality(
        europeanAqi: 20,
        usAqi: 25,
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

void main() {
  testWidgets('SplashScreen renders branding elements and updates active location', (tester) async {
    final fakeLocationRepo = FakeLocationRepository();
    final fakeWeatherRepo = FakeWeatherRepository();

    final container = ProviderContainer(
      overrides: [
        locationRepositoryProvider.overrideWithValue(fakeLocationRepo),
        weatherRepositoryProvider.overrideWithValue(fakeWeatherRepo),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.darkTheme,
          home: const SplashScreen(),
        ),
      ),
    );

    // Initial branding checks
    expect(find.text('MetroSky'), findsOneWidget);
    expect(find.text('Precision Atmospheric Forecasting'), findsOneWidget);
    expect(find.byIcon(LucideIcons.cloudSun), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);

    // Allow post-frame callbacks and initialization to progress
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 1600));

    // Verify active location was updated to Sydney from GPS sensor
    final activeLocation = container.read(activeWeatherLocationProvider);
    expect(activeLocation.cityName, 'Sydney');
    expect(activeLocation.latitude, -33.8688);
    expect(activeLocation.longitude, 151.2093);
  });
}
