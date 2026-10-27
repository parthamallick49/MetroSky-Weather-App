import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/location_repository_impl.dart';
import '../../domain/entities/location_item.dart';

/// Riverpod AsyncNotifier managing the user's saved favorite locations.
class SavedLocationsController extends AsyncNotifier<List<LocationItem>> {
  @override
  FutureOr<List<LocationItem>> build() async {
    final repository = ref.watch(locationRepositoryProvider);
    return repository.getSavedLocations();
  }

  /// Adds a new location to saved favorites.
  Future<void> addLocation(LocationItem location) async {
    final repository = ref.read(locationRepositoryProvider);
    await repository.saveLocation(location);
    state = AsyncValue.data(await repository.getSavedLocations());
  }

  /// Removes a location from saved favorites.
  Future<void> removeLocation(LocationItem location) async {
    final repository = ref.read(locationRepositoryProvider);
    await repository.deleteLocation(location);
    state = AsyncValue.data(await repository.getSavedLocations());
  }

  /// Reorders saved locations.
  Future<void> reorder(int oldIndex, int newIndex) async {
    final repository = ref.read(locationRepositoryProvider);
    await repository.reorderLocations(oldIndex, newIndex);
    state = AsyncValue.data(await repository.getSavedLocations());
  }

  /// Fetches current GPS location from sensor and returns it.
  Future<LocationItem> getCurrentGpsLocation() async {
    final repository = ref.read(locationRepositoryProvider);
    return repository.getCurrentDeviceLocation();
  }
}

/// Global provider for [SavedLocationsController].
final savedLocationsControllerProvider =
    AsyncNotifierProvider<SavedLocationsController, List<LocationItem>>(
  SavedLocationsController.new,
);
