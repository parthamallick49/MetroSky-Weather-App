import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../domain/entities/user_preferences.dart';

/// Provider for user preferences with instant synchronous fallback.
final userPreferencesProvider = Provider<UserPreferences>((ref) {
  final asyncState = ref.watch(settingsControllerProvider);
  return asyncState.valueOrNull ?? const UserPreferences();
});

final settingsControllerProvider =
    AsyncNotifierProvider<SettingsController, UserPreferences>(SettingsController.new);

class SettingsController extends AsyncNotifier<UserPreferences> {
  @override
  FutureOr<UserPreferences> build() async {
    final repo = ref.watch(settingsRepositoryProvider);
    return repo.loadPreferences();
  }

  Future<void> _update(UserPreferences Function(UserPreferences current) mutate) async {
    final current = state.valueOrNull ?? const UserPreferences();
    final updated = mutate(current);
    // Optimistic state update
    state = AsyncData(updated);

    try {
      final repo = ref.read(settingsRepositoryProvider);
      await repo.savePreferences(updated);
    } catch (e, st) {
      // Revert on error
      state = AsyncError(e, st);
    }
  }

  void setTemperatureUnit(TemperatureUnit unit) {
    _update((current) => current.copyWith(temperatureUnit: unit));
  }

  void setWindSpeedUnit(WindSpeedUnit unit) {
    _update((current) => current.copyWith(windSpeedUnit: unit));
  }

  void setPressureUnit(PressureUnit unit) {
    _update((current) => current.copyWith(pressureUnit: unit));
  }

  void setPrecipitationUnit(PrecipitationUnit unit) {
    _update((current) => current.copyWith(precipitationUnit: unit));
  }

  void toggleShaders(bool enabled) {
    _update((current) => current.copyWith(enableShaders: enabled));
  }

  void toggleParticles(bool enabled) {
    _update((current) => current.copyWith(enableParticles: enabled));
  }

  void toggleHaptics(bool enabled) {
    _update((current) => current.copyWith(enableHaptics: enabled));
  }
}
