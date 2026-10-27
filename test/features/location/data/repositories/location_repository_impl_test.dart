import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/location/data/datasources/device_location_datasource.dart';
import 'package:weather_app/features/location/data/datasources/geocoding_remote_datasource.dart';
import 'package:weather_app/features/location/data/datasources/location_local_datasource.dart';
import 'package:weather_app/features/location/data/repositories/location_repository_impl.dart';
import 'package:weather_app/features/location/domain/entities/location_item.dart';

class MockGeocodingRemoteDataSource implements GeocodingRemoteDataSource {
  bool shouldReturnCity = true;

  @override
  Future<List<LocationItem>> searchCities(String query) async {
    if (query == 'Paris') {
      return const [
        LocationItem(name: 'Paris', country: 'France', latitude: 48.85, longitude: 2.35),
      ];
    }
    return [];
  }

  @override
  Future<LocationItem?> reverseGeocode({
    required double latitude,
    required double longitude,
  }) async {
    if (shouldReturnCity) {
      return LocationItem(
        name: 'San Francisco',
        country: 'United States',
        latitude: latitude,
        longitude: longitude,
        isCurrentLocation: true,
      );
    }
    return null;
  }
}

class MockLocationLocalDataSource implements LocationLocalDataSource {
  List<LocationItem> savedList = [
    const LocationItem(name: 'London', country: 'UK', latitude: 51.5, longitude: -0.1),
    const LocationItem(name: 'Tokyo', country: 'Japan', latitude: 35.6, longitude: 139.6),
  ];

  @override
  Future<List<LocationItem>> getSavedLocations() async => savedList;

  @override
  Future<void> saveLocations(List<LocationItem> locations) async {
    savedList = List.from(locations);
  }
}

class MockDeviceLocationDataSource implements DeviceLocationDataSource {
  @override
  Future<LocationItem> getCurrentPosition() async {
    return const LocationItem(
      name: 'Current Location',
      country: 'GPS',
      latitude: 37.7749,
      longitude: -122.4194,
      isCurrentLocation: true,
    );
  }
}

void main() {
  group('LocationRepositoryImpl', () {
    late MockGeocodingRemoteDataSource remote;
    late MockLocationLocalDataSource local;
    late MockDeviceLocationDataSource device;
    late LocationRepositoryImpl repository;

    setUp(() {
      remote = MockGeocodingRemoteDataSource();
      local = MockLocationLocalDataSource();
      device = MockDeviceLocationDataSource();
      repository = LocationRepositoryImpl(
        remoteDataSource: remote,
        localDataSource: local,
        deviceLocationDataSource: device,
      );
    });

    test('searches cities from remote data source', () async {
      final results = await repository.searchCities('Paris');
      expect(results.length, 1);
      expect(results.first.name, 'Paris');
    });

    test('saves new location and prevents exact duplicates', () async {
      const newCity = LocationItem(name: 'Berlin', country: 'Germany', latitude: 52.52, longitude: 13.40);
      await repository.saveLocation(newCity);

      final list = await repository.getSavedLocations();
      expect(list.length, 3);
      expect(list.last.name, 'Berlin');

      // Attempt duplicate save
      await repository.saveLocation(newCity);
      final listAfter = await repository.getSavedLocations();
      expect(listAfter.length, 3);
    });

    test('deletes location by coordinate match', () async {
      const toDelete = LocationItem(name: 'London', country: 'UK', latitude: 51.5, longitude: -0.1);
      await repository.deleteLocation(toDelete);

      final list = await repository.getSavedLocations();
      expect(list.length, 1);
      expect(list.first.name, 'Tokyo');
    });

    test('reorders locations list properly', () async {
      // Current: [London, Tokyo] -> reorder index 1 to 0
      await repository.reorderLocations(1, 0);

      final list = await repository.getSavedLocations();
      expect(list.first.name, 'Tokyo');
      expect(list.last.name, 'London');
    });

    test('retrieves current device GPS position with reverse-geocoded city name', () async {
      final gpsLocation = await repository.getCurrentDeviceLocation();
      expect(gpsLocation.isCurrentLocation, isTrue);
      expect(gpsLocation.latitude, 37.7749);
      expect(gpsLocation.name, 'San Francisco');
      expect(gpsLocation.country, 'United States');
    });

    test('falls back to raw position if reverse geocoding returns null', () async {
      remote.shouldReturnCity = false;
      final gpsLocation = await repository.getCurrentDeviceLocation();
      expect(gpsLocation.isCurrentLocation, isTrue);
      expect(gpsLocation.latitude, 37.7749);
      expect(gpsLocation.name, 'Current Location');
      expect(gpsLocation.country, 'GPS');
    });
  });
}
