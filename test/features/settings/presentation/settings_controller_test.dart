import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:weather_app/features/settings/domain/entities/user_preferences.dart';
import 'package:weather_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:weather_app/features/settings/presentation/controllers/settings_controller.dart';

class FakeSettingsRepository implements SettingsRepository {
  UserPreferences preferences = const UserPreferences();

  @override
  Future<UserPreferences> loadPreferences() async => preferences;

  @override
  Future<void> savePreferences(UserPreferences updated) async {
    preferences = updated;
  }
}

void main() {
  group('SettingsController', () {
    late FakeSettingsRepository fakeRepo;
    late ProviderContainer container;

    setUp(() {
      fakeRepo = FakeSettingsRepository();
      container = ProviderContainer(
        overrides: [
          settingsRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state loads default preferences', () async {
      final initial = await container.read(settingsControllerProvider.future);
      expect(initial.temperatureUnit, TemperatureUnit.celsius);
      expect(initial.windSpeedUnit, WindSpeedUnit.kmh);
      expect(initial.pressureUnit, PressureUnit.hPa);
      expect(initial.enableShaders, isTrue);
    });

    test('setTemperatureUnit updates state and repository', () async {
      await container.read(settingsControllerProvider.future);

      container.read(settingsControllerProvider.notifier).setTemperatureUnit(TemperatureUnit.fahrenheit);

      final updated = container.read(userPreferencesProvider);
      expect(updated.temperatureUnit, TemperatureUnit.fahrenheit);
      expect(fakeRepo.preferences.temperatureUnit, TemperatureUnit.fahrenheit);
    });

    test('toggleShaders updates GPU shader flag', () async {
      await container.read(settingsControllerProvider.future);

      container.read(settingsControllerProvider.notifier).toggleShaders(false);

      final updated = container.read(userPreferencesProvider);
      expect(updated.enableShaders, isFalse);
      expect(fakeRepo.preferences.enableShaders, isFalse);
    });

    test('toggleParticles and toggleHaptics update flags properly', () async {
      await container.read(settingsControllerProvider.future);

      container.read(settingsControllerProvider.notifier).toggleParticles(false);
      container.read(settingsControllerProvider.notifier).toggleHaptics(false);

      final updated = container.read(userPreferencesProvider);
      expect(updated.enableParticles, isFalse);
      expect(updated.enableHaptics, isFalse);
    });
  });
}
