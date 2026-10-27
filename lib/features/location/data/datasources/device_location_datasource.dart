import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/location_item.dart';

/// Data source interacting with device hardware sensors via [Geolocator].
abstract class DeviceLocationDataSource {
  Future<LocationItem> getCurrentPosition();
}

class DeviceLocationDataSourceImpl implements DeviceLocationDataSource {
  @override
  Future<LocationItem> getCurrentPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const LocationException(
        message: 'Location services are disabled on your device. Please enable GPS in settings.',
      );
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw const LocationException(
          message: 'Location permission was denied. Weather for current location cannot be retrieved.',
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw const LocationException(
        message: 'Location permissions are permanently denied. Please grant permission in application settings.',
      );
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium,
      timeLimit: const Duration(seconds: 10),
    );

    return LocationItem(
      name: 'Current Location',
      country: 'GPS',
      latitude: position.latitude,
      longitude: position.longitude,
      isCurrentLocation: true,
    );
  }
}

/// Riverpod provider for [DeviceLocationDataSource].
final deviceLocationDataSourceProvider = Provider<DeviceLocationDataSource>((ref) {
  return DeviceLocationDataSourceImpl();
});
