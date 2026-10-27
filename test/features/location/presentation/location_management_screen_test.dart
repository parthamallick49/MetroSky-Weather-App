import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/features/location/domain/entities/location_item.dart';
import 'package:weather_app/features/location/presentation/controllers/saved_locations_controller.dart';
import 'package:weather_app/features/location/presentation/widgets/location_management_screen.dart';

void main() {
  testWidgets('LocationManagementScreen mounts and displays saved locations and GPS action', (tester) async {
    final sampleLocations = [
      const LocationItem(name: 'Paris', country: 'France', latitude: 48.85, longitude: 2.35),
      const LocationItem(name: 'Tokyo', country: 'Japan', latitude: 35.6, longitude: 139.6),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          savedLocationsControllerProvider.overrideWith(
            () => _FakeSavedLocationsController(sampleLocations),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.darkTheme,
          home: const LocationManagementScreen(),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Manage Locations'), findsOneWidget);
    expect(find.text('Use Current GPS Location'), findsOneWidget);
    expect(find.text('SAVED CITIES'), findsOneWidget);
    expect(find.text('Paris'), findsOneWidget);
    expect(find.text('Tokyo'), findsOneWidget);
  });
}

class _FakeSavedLocationsController extends SavedLocationsController {
  _FakeSavedLocationsController(this._locations);
  final List<LocationItem> _locations;

  @override
  Future<List<LocationItem>> build() async => _locations;
}
