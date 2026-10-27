import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_dashboard_screen.dart';

void main() {
  testWidgets('WeatherDashboardScreen mounts and displays initial glass card', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.darkTheme,
          home: const WeatherDashboardScreen(),
        ),
      ),
    );

    expect(find.text('Weather'), findsOneWidget);
    expect(find.text('Core Foundation Initialized'), findsOneWidget);
  });
}
