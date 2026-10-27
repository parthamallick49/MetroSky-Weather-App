import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:weather_app/features/settings/domain/entities/user_preferences.dart';
import 'package:weather_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:weather_app/features/settings/presentation/widgets/settings_screen.dart';

class FakeSettingsRepo implements SettingsRepository {
  UserPreferences preferences = const UserPreferences();

  @override
  Future<UserPreferences> loadPreferences() async => preferences;

  @override
  Future<void> savePreferences(UserPreferences updated) async {
    preferences = updated;
  }
}

void main() {
  testWidgets('SettingsScreen mounts and allows toggling unit options', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    addTearDown(tester.view.resetPhysicalSize);

    final fakeRepo = FakeSettingsRepo();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          settingsRepositoryProvider.overrideWithValue(fakeRepo),
        ],
        child: const MaterialApp(
          home: SettingsScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('UNITS'), findsOneWidget);
    expect(find.text('PERFORMANCE & GRAPHICS'), findsOneWidget);

    // Tap Fahrenheit option before scrolling
    await tester.tap(find.text('°F'));
    await tester.pumpAndSettle();

    expect(fakeRepo.preferences.temperatureUnit, TemperatureUnit.fahrenheit);

    // Scroll to attribution section
    await tester.scrollUntilVisible(find.text('DATA SOURCES & ATTRIBUTION'), 300);
    expect(find.text('DATA SOURCES & ATTRIBUTION'), findsOneWidget);
  });
}
