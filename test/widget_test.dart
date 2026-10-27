import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/features/weather/domain/entities/air_quality.dart';
import 'package:weather_app/features/weather/domain/entities/current_weather.dart';
import 'package:weather_app/features/weather/domain/entities/daily_forecast.dart';
import 'package:weather_app/features/weather/domain/entities/forecast.dart';
import 'package:weather_app/features/weather/domain/entities/hourly_weather.dart';
import 'package:weather_app/features/weather/presentation/controllers/weather_controller.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_dashboard_screen.dart';

void main() {
  final sampleForecast = Forecast(
    latitude: 51.5074,
    longitude: -0.1278,
    timezone: 'Europe/London',
    current: CurrentWeather(
      temperature: 18.0,
      apparentTemperature: 17.0,
      relativeHumidity: 65,
      surfacePressure: 1015.0,
      windSpeed: 12.0,
      windDirection: 220.0,
      precipitation: 0.0,
      weatherCode: 2,
      isDay: true,
      time: DateTime.now(),
    ),
    hourly: [
      HourlyWeather(
        time: DateTime.now(),
        temperature: 18.0,
        relativeHumidity: 65,
        dewPoint: 11.0,
        precipitationProbability: 10,
        precipitation: 0.0,
        weatherCode: 2,
        surfacePressure: 1015.0,
        visibility: 10000.0,
        windSpeed: 12.0,
        uvIndex: 3.0,
        isDay: true,
      ),
    ],
    daily: [
      DailyForecast(
        date: DateTime.now(),
        maxTemperature: 21.0,
        minTemperature: 13.0,
        weatherCode: 2,
        sunrise: DateTime.now().copyWith(hour: 6, minute: 45),
        sunset: DateTime.now().copyWith(hour: 17, minute: 50),
        uvIndexMax: 4.2,
        precipitationSum: 0.0,
        precipitationProbabilityMax: 10,
      ),
    ],
    airQuality: const AirQuality(
      europeanAqi: 24,
      usAqi: 38,
      pm10: 12.0,
      pm25: 6.5,
      carbonMonoxide: 210.0,
      nitrogenDioxide: 18.0,
      sulphurDioxide: 2.0,
      ozone: 36.0,
    ),
    fetchedAt: DateTime.now(),
  );

  testWidgets('WeatherDashboardScreen renders live forecast data and bento cards', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          weatherControllerProvider.overrideWith(
            () => _FakeWeatherController(sampleForecast),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.darkTheme,
          home: const WeatherDashboardScreen(),
        ),
      ),
    );

    // Initial frame
    await tester.pump();

    // Verify Hero section
    expect(find.text('London'), findsNWidgets(2)); // Nav header + Hero title
    expect(find.text('18°'), findsWidgets);
    expect(find.text('Partly Cloudy'), findsOneWidget);

    // Verify Hourly and Daily sections
    expect(find.text('HOURLY FORECAST'), findsOneWidget);
    expect(find.text('7-DAY FORECAST'), findsOneWidget);

    // Verify Bento Grid cards
    expect(find.text('UV INDEX'), findsOneWidget);
    expect(find.text('WIND'), findsOneWidget);
    expect(find.text('SUNRISE & SUNSET'), findsOneWidget);
    expect(find.text('AIR QUALITY'), findsOneWidget);
    expect(find.text('PRESSURE & HUMIDITY'), findsOneWidget);
  });
}

class _FakeWeatherController extends WeatherController {
  _FakeWeatherController(this._forecast);
  final Forecast _forecast;

  @override
  Future<Forecast> build() async => _forecast;
}
