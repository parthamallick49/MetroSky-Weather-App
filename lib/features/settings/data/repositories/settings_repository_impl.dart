import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/persistence/hive_storage_service.dart';
import '../../domain/entities/user_preferences.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_datasource.dart';

final settingsLocalDataSourceProvider = Provider<SettingsLocalDataSource>((ref) {
  final storageService = ref.watch(hiveStorageServiceProvider);
  return SettingsLocalDataSourceImpl(storageService: storageService);
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final dataSource = ref.watch(settingsLocalDataSourceProvider);
  return SettingsRepositoryImpl(dataSource: dataSource);
});

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _dataSource;

  SettingsRepositoryImpl({required SettingsLocalDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<UserPreferences> loadPreferences() => _dataSource.getPreferences();

  @override
  Future<void> savePreferences(UserPreferences preferences) =>
      _dataSource.cachePreferences(preferences);
}
