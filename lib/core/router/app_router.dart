import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/location/presentation/widgets/location_management_screen.dart';
import '../../features/radar/presentation/widgets/radar_map_screen.dart';
import '../../features/settings/presentation/widgets/settings_screen.dart';
import '../../features/splash/presentation/widgets/splash_screen.dart';
import '../../features/weather/presentation/widgets/weather_dashboard_screen.dart';

/// Top-level application routes enum.
enum AppRoute {
  splash('/'),
  dashboard('/dashboard'),
  locationManagement('/locations'),
  radarMap('/radar'),
  settings('/settings');

  const AppRoute(this.path);
  final String path;
}

/// Declarative GoRouter configuration.
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoute.splash.path,
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoute.dashboard.path,
        name: AppRoute.dashboard.name,
        builder: (context, state) => const WeatherDashboardScreen(),
      ),
      GoRoute(
        path: AppRoute.locationManagement.path,
        name: AppRoute.locationManagement.name,
        builder: (context, state) => const LocationManagementScreen(),
      ),
      GoRoute(
        path: AppRoute.radarMap.path,
        name: AppRoute.radarMap.name,
        builder: (context, state) => const RadarMapScreen(),
      ),
      GoRoute(
        path: AppRoute.settings.path,
        name: AppRoute.settings.name,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri.path}'),
      ),
    ),
  );
});
