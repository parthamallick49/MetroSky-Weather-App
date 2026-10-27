import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

/// Centralized local storage service managing Hive CE boxes.
class HiveStorageService {
  HiveStorageService._();

  static const String weatherCacheBoxName = 'weather_cache_box';
  static const String savedLocationsBoxName = 'saved_locations_box';
  static const String preferencesBoxName = 'preferences_box';

  static late Box<dynamic> _weatherCacheBox;
  static late Box<dynamic> _savedLocationsBox;
  static late Box<dynamic> _preferencesBox;

  /// Initializes Hive for Flutter and opens core boxes.
  static Future<void> init() async {
    await Hive.initFlutter();
    
    _weatherCacheBox = await Hive.openBox<dynamic>(weatherCacheBoxName);
    _savedLocationsBox = await Hive.openBox<dynamic>(savedLocationsBoxName);
    _preferencesBox = await Hive.openBox<dynamic>(preferencesBoxName);
  }

  /// Weather forecast cache box.
  Box<dynamic> get weatherCacheBox => _weatherCacheBox;

  /// Saved / favorite cities box.
  Box<dynamic> get savedLocationsBox => _savedLocationsBox;

  /// User preferences (units, appearance) box.
  Box<dynamic> get preferencesBox => _preferencesBox;

  /// Clears all stored cache in all boxes.
  Future<void> clearAll() async {
    await _weatherCacheBox.clear();
    await _savedLocationsBox.clear();
    await _preferencesBox.clear();
  }
}

/// Global provider for [HiveStorageService].
final hiveStorageServiceProvider = Provider<HiveStorageService>((ref) {
  return HiveStorageService._();
});
