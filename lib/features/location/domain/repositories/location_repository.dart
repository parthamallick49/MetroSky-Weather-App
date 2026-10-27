import '../entities/location_item.dart';

/// Abstract contract for geocoding search, saved locations persistence, and GPS services.
abstract class LocationRepository {
  /// Searches for global cities matching [query] with autocomplete.
  Future<List<LocationItem>> searchCities(String query);

  /// Retrieves the list of user-saved favorite locations from local storage.
  Future<List<LocationItem>> getSavedLocations();

  /// Adds a new location to user favorites.
  Future<void> saveLocation(LocationItem location);

  /// Removes a location from user favorites.
  Future<void> deleteLocation(LocationItem location);

  /// Updates the order of saved locations in local storage.
  Future<void> reorderLocations(int oldIndex, int newIndex);

  /// Queries the device GPS sensor to determine current coordinates.
  Future<LocationItem> getCurrentDeviceLocation();
}
