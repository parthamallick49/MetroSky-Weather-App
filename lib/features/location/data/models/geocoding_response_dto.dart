import '../../domain/entities/location_item.dart';

/// DTO parser for Open-Meteo Geocoding Autocomplete API response.
class GeocodingResponseDto {
  GeocodingResponseDto({required this.results});

  factory GeocodingResponseDto.fromJson(Map<String, dynamic> json) {
    final rawResults = (json['results'] as List<dynamic>?) ?? [];

    final list = rawResults.map((item) {
      final map = item as Map<String, dynamic>;
      return LocationItem(
        name: map['name']?.toString() ?? '',
        latitude: (map['latitude'] as num?)?.toDouble() ?? 0.0,
        longitude: (map['longitude'] as num?)?.toDouble() ?? 0.0,
        country: map['country']?.toString() ?? '',
        admin1: map['admin1']?.toString(),
        timezone: map['timezone']?.toString() ?? 'UTC',
      );
    }).toList();

    return GeocodingResponseDto(results: list);
  }

  final List<LocationItem> results;
}
