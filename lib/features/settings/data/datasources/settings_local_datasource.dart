import 'dart:convert';
import 'package:hive_ce/hive.dart';
import '../../../../core/persistence/hive_storage_service.dart';
import '../../domain/entities/user_preferences.dart';

abstract class SettingsLocalDataSource {
  Future<UserPreferences> getPreferences();
  Future<void> cachePreferences(UserPreferences preferences);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final Box<dynamic> _box;
  static const _preferencesKey = 'app_user_preferences';

  SettingsLocalDataSourceImpl({required HiveStorageService storageService})
      : _box = storageService.preferencesBox;

  SettingsLocalDataSourceImpl.withBox(Box<dynamic> box) : _box = box;

  @override
  Future<UserPreferences> getPreferences() async {
    final raw = _box.get(_preferencesKey);
    if (raw == null) {
      return const UserPreferences();
    }
    if (raw is Map) {
      final map = Map<String, dynamic>.from(raw);
      return UserPreferences.fromJson(map);
    }
    if (raw is String) {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return UserPreferences.fromJson(map);
    }
    return const UserPreferences();
  }

  @override
  Future<void> cachePreferences(UserPreferences preferences) async {
    await _box.put(_preferencesKey, preferences.toJson());
  }
}
