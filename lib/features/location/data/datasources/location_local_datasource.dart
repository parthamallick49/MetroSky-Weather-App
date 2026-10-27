import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/persistence/hive_storage_service.dart';
import '../../domain/entities/location_item.dart';

/// Local data source persisting user favorite locations in Hive CE.
abstract class LocationLocalDataSource {
  Future<List<LocationItem>> getSavedLocations();
  Future<void> saveLocations(List<LocationItem> locations);
}

class LocationLocalDataSourceImpl implements LocationLocalDataSource {
  LocationLocalDataSourceImpl({required HiveStorageService storageService})
      : _storageService = storageService;

  final HiveStorageService _storageService;
  static const String _savedLocationsKey = 'saved_locations_list';

  @override
  Future<List<LocationItem>> getSavedLocations() async {
    try {
      final raw = _storageService.savedLocationsBox.get(_savedLocationsKey);
      if (raw == null) {
        // Default initial preset favorites
        return const [
          LocationItem(
            name: 'London',
            country: 'United Kingdom',
            latitude: 51.5074,
            longitude: -0.1278,
            timezone: 'Europe/London',
          ),
          LocationItem(
            name: 'New York',
            country: 'United States',
            admin1: 'New York',
            latitude: 40.7128,
            longitude: -74.0060,
            timezone: 'America/New_York',
          ),
          LocationItem(
            name: 'Tokyo',
            country: 'Japan',
            latitude: 35.6762,
            longitude: 139.6503,
            timezone: 'Asia/Tokyo',
          ),
        ];
      }

      final List<dynamic> list;
      if (raw is String) {
        list = json.decode(raw) as List<dynamic>;
      } else if (raw is List) {
        list = raw;
      } else {
        return [];
      }

      return list
          .map((item) => LocationItem.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> saveLocations(List<LocationItem> locations) async {
    final jsonList = locations.map((loc) => loc.toJson()).toList();
    await _storageService.savedLocationsBox.put(
      _savedLocationsKey,
      json.encode(jsonList),
    );
  }
}

/// Riverpod provider for [LocationLocalDataSource].
final locationLocalDataSourceProvider = Provider<LocationLocalDataSource>((ref) {
  final storageService = ref.watch(hiveStorageServiceProvider);
  return LocationLocalDataSourceImpl(storageService: storageService);
});
