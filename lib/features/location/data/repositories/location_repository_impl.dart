import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/location_item.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/device_location_datasource.dart';
import '../datasources/geocoding_remote_datasource.dart';
import '../datasources/location_local_datasource.dart';

/// Implementation of [LocationRepository] coordinating geocoding, persistence, and GPS.
class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl({
    required GeocodingRemoteDataSource remoteDataSource,
    required LocationLocalDataSource localDataSource,
    required DeviceLocationDataSource deviceLocationDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _deviceLocationDataSource = deviceLocationDataSource;

  final GeocodingRemoteDataSource _remoteDataSource;
  final LocationLocalDataSource _localDataSource;
  final DeviceLocationDataSource _deviceLocationDataSource;

  @override
  Future<List<LocationItem>> searchCities(String query) async {
    try {
      return await _remoteDataSource.searchCities(query);
    } on AppException catch (e) {
      if (e is ServerException) {
        throw ServerFailure(message: e.message, statusCode: e.statusCode);
      } else if (e is NetworkException) {
        throw NetworkFailure(message: e.message, statusCode: e.statusCode);
      }
      throw UnknownFailure(message: e.message);
    } catch (e) {
      throw UnknownFailure(message: e.toString());
    }
  }

  @override
  Future<List<LocationItem>> getSavedLocations() async {
    return _localDataSource.getSavedLocations();
  }

  @override
  Future<void> saveLocation(LocationItem location) async {
    final list = await _localDataSource.getSavedLocations();
    // Prevent duplicate entries by coordinate proximity
    final exists = list.any((loc) =>
        (loc.latitude - location.latitude).abs() < 0.01 &&
        (loc.longitude - location.longitude).abs() < 0.01);

    if (!exists) {
      final updated = [...list, location];
      await _localDataSource.saveLocations(updated);
    }
  }

  @override
  Future<void> deleteLocation(LocationItem location) async {
    final list = await _localDataSource.getSavedLocations();
    final updated = list
        .where((loc) =>
            (loc.latitude - location.latitude).abs() >= 0.01 ||
            (loc.longitude - location.longitude).abs() >= 0.01)
        .toList();
    await _localDataSource.saveLocations(updated);
  }

  @override
  Future<void> reorderLocations(int oldIndex, int newIndex) async {
    final list = await _localDataSource.getSavedLocations();
    if (oldIndex < 0 || oldIndex >= list.length || newIndex < 0) return;

    var targetIndex = newIndex;
    if (oldIndex < targetIndex) {
      targetIndex -= 1;
    }

    final mutable = List<LocationItem>.from(list);
    final item = mutable.removeAt(oldIndex);
    mutable.insert(targetIndex, item);

    await _localDataSource.saveLocations(mutable);
  }

  @override
  Future<LocationItem> getCurrentDeviceLocation() async {
    try {
      return await _deviceLocationDataSource.getCurrentPosition();
    } on LocationException catch (e) {
      throw LocationFailure(message: e.message, statusCode: e.statusCode);
    } catch (e) {
      throw UnknownFailure(message: e.toString());
    }
  }
}

/// Riverpod provider for [LocationRepository].
final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  final remote = ref.watch(geocodingRemoteDataSourceProvider);
  final local = ref.watch(locationLocalDataSourceProvider);
  final device = ref.watch(deviceLocationDataSourceProvider);

  return LocationRepositoryImpl(
    remoteDataSource: remote,
    localDataSource: local,
    deviceLocationDataSource: device,
  );
});
