import '../entities/user_preferences.dart';

abstract class SettingsRepository {
  Future<UserPreferences> loadPreferences();
  Future<void> savePreferences(UserPreferences preferences);
}
