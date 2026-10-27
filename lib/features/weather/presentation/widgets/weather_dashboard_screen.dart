import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/solar_calculator.dart';
import '../../../../core/widgets/app_error_state_view.dart';
import '../../../../core/widgets/app_glass_card.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../core/widgets/app_shimmer_placeholder.dart';
import '../../../visual_engine/presentation/weather_scene_scaffold.dart';
import '../controllers/weather_controller.dart';
import 'bento_grid/air_quality_card.dart';
import 'bento_grid/pressure_card.dart';
import 'bento_grid/sunrise_sunset_card.dart';
import 'bento_grid/uv_index_card.dart';
import 'bento_grid/wind_compass_card.dart';
import 'daily_forecast_list.dart';
import 'hero_condition_view.dart';
import 'hourly_temperature_chart.dart';

/// Full interactive weather dashboard screen displaying live weather, forecast trends, and bento metrics.
class WeatherDashboardScreen extends ConsumerWidget {
  const WeatherDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherControllerProvider);
    final activeLocation = ref.watch(activeWeatherLocationProvider);

    return weatherAsync.when(
      loading: () => const _DashboardLoadingSkeleton(),
      error: (error, _) => Scaffold(
        backgroundColor: AppColors.skyNightTop,
        body: SafeArea(
          child: AppErrorStateView(
            message: error.toString(),
            onRetry: () => ref.read(weatherControllerProvider.notifier).refresh(),
          ),
        ),
      ),
      data: (forecast) {
        // Calculate solar elevation angle for ambient lighting
        final solarPosition = SolarCalculator.calculate(
          latitude: forecast.latitude,
          longitude: forecast.longitude,
          utcDateTime: DateTime.now().toUtc(),
        );

        final firstDaily = forecast.daily.isNotEmpty ? forecast.daily.first : null;
        final dewPoint = forecast.hourly.isNotEmpty ? forecast.hourly.first.dewPoint : 10.0;
        final uvMax = firstDaily?.uvIndexMax ?? 3.0;
        final sunrise = firstDaily?.sunrise ?? DateTime.now().copyWith(hour: 6, minute: 30);
        final sunset = firstDaily?.sunset ?? DateTime.now().copyWith(hour: 18, minute: 30);

        return WeatherSceneScaffold(
          conditionCategory: forecast.current.category,
          solarElevation: solarPosition.elevationDegrees,
          windSpeedKmh: forecast.current.windSpeed,
          child: SafeArea(
            bottom: false,
            child: RefreshIndicator(
              color: Colors.white,
              backgroundColor: const Color(0x33FFFFFF),
              onRefresh: () => ref.read(weatherControllerProvider.notifier).refresh(),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                slivers: [
                  // App Bar Navigation Row
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppIconButton(
                            icon: LucideIcons.menu,
                            tooltip: 'Locations',
                            onPressed: () => context.push(AppRoute.locationManagement.path),
                          ),
                          Text(
                            activeLocation.cityName,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppIconButton(
                                icon: LucideIcons.radar,
                                tooltip: 'Radar Map',
                                onPressed: () => context.push(AppRoute.radarMap.path),
                              ),
                              const SizedBox(width: 8.0),
                              AppIconButton(
                                icon: LucideIcons.settings,
                                tooltip: 'Settings',
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Hero Condition View
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: HeroConditionView(
                        cityName: activeLocation.cityName,
                        current: forecast.current,
                        todayDaily: firstDaily,
                      ),
                    ),
                  ),

                  // 24-Hour Hourly Forecast
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      child: HourlyTemperatureChart(
                        hourlyForecasts: forecast.hourly,
                      ),
                    ),
                  ),

                  // 7-Day Forecast List
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      child: DailyForecastList(
                        dailyForecasts: forecast.daily,
                      ),
                    ),
                  ),

                  // Bento Grid Section
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 40.0),
                    sliver: SliverGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 16.0,
                      childAspectRatio: 0.95,
                      children: [
                        // 1. UV Index
                        UvIndexCard(uvIndex: uvMax),

                        // 2. Wind Compass
                        WindCompassCard(
                          windSpeedKmh: forecast.current.windSpeed,
                          windDirectionDegrees: forecast.current.windDirection,
                        ),

                        // 3. Sunrise & Sunset
                        SunriseSunsetCard(
                          sunrise: sunrise,
                          sunset: sunset,
                        ),

                        // 4. Air Quality
                        AirQualityCard(
                          airQuality: forecast.airQuality,
                        ),
                      ],
                    ),
                  ),

                  // Full-width Bento Pressure & Humidity Card
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 48.0),
                      child: SizedBox(
                        height: 180.0,
                        child: PressureCard(
                          surfacePressureHpa: forecast.current.surfacePressure,
                          relativeHumidity: forecast.current.relativeHumidity,
                          dewPointCelsius: dewPoint,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Glassmorphic shimmer placeholder skeleton shown during initial hydration.
class _DashboardLoadingSkeleton extends StatelessWidget {
  const _DashboardLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.skyNightTop,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                // Header Nav
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppShimmerPlaceholder.circular(size: 44.0),
                    AppShimmerPlaceholder(width: 120.0, height: 24.0),
                    AppShimmerPlaceholder.circular(size: 44.0),
                  ],
                ),
                SizedBox(height: 36.0),

                // Hero Skeleton
                AppShimmerPlaceholder(width: 160.0, height: 28.0),
                SizedBox(height: 16.0),
                AppShimmerPlaceholder(width: 200.0, height: 84.0),
                SizedBox(height: 12.0),
                AppShimmerPlaceholder(width: 140.0, height: 20.0),
                SizedBox(height: 32.0),

                // Hourly Chart Skeleton
                AppGlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppShimmerPlaceholder(width: 140.0, height: 16.0),
                      SizedBox(height: 16.0),
                      SizedBox(
                        height: 100.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppShimmerPlaceholder(width: 48.0, height: 96.0),
                            AppShimmerPlaceholder(width: 48.0, height: 96.0),
                            AppShimmerPlaceholder(width: 48.0, height: 96.0),
                            AppShimmerPlaceholder(width: 48.0, height: 96.0),
                            AppShimmerPlaceholder(width: 48.0, height: 96.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),

                // 7-Day Forecast Skeleton
                AppGlassCard(
                  height: 180.0,
                  child: Center(
                    child: AppShimmerPlaceholder(width: double.infinity, height: 140.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
