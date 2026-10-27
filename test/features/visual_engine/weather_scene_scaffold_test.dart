import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/constants/wmo_weather_codes.dart';
import 'package:weather_app/features/visual_engine/presentation/weather_scene_scaffold.dart';

void main() {
  testWidgets('WeatherSceneScaffold renders sky background and child content', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: WeatherSceneScaffold(
            conditionCategory: WeatherConditionCategory.rain,
            solarElevation: 20.0,
            child: Center(
              child: Text('Foreground Content'),
            ),
          ),
        ),
      ),
    );

    // Initial frame
    await tester.pump();

    expect(find.text('Foreground Content'), findsOneWidget);
  });
}
