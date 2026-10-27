import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/weather/presentation/widgets/weather_dashboard_screen.dart';

/// Top-level application routes enum.
enum AppRoute {
  dashboard('/'),
  locationManagement('/locations'),
  radarMap('/radar'),
  settings('/settings');

  const AppRoute(this.path);
  final String path;
}

/// Declarative GoRouter configuration.
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoute.dashboard.path,
    routes: [
      GoRoute(
        path: AppRoute.dashboard.path,
        name: AppRoute.dashboard.name,
        builder: (context, state) => const WeatherDashboardScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri.path}'),
      ),
    ),
  );
});
