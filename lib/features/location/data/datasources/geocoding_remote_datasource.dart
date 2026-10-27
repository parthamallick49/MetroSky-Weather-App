import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/location_item.dart';
import '../models/geocoding_response_dto.dart';

/// Remote data source executing search queries and reverse geocoding against geocoding APIs.
abstract class GeocodingRemoteDataSource {
  Future<List<LocationItem>> searchCities(String query);

  /// Reverse geocodes coordinates to a human-readable city and country name.
  Future<LocationItem?> reverseGeocode({
    required double latitude,
    required double longitude,
  });
}

class GeocodingRemoteDataSourceImpl implements GeocodingRemoteDataSource {
  GeocodingRemoteDataSourceImpl({required DioClient dioClient})
      : _dioClient = dioClient;

  final DioClient _dioClient;

  @override
  Future<List<LocationItem>> searchCities(String query) async {
    final trimmed = query.trim();
    if (trimmed.length < 2) return [];

    final response = await _dioClient.get<Map<String, dynamic>>(
      '${ApiEndpoints.openMeteoGeocodingBaseUrl}/search',
      queryParameters: {
        'name': trimmed,
        'count': 10,
        'language': 'en',
        'format': 'json',
      },
    );

    final dto = GeocodingResponseDto.fromJson(response.data ?? {});
    return dto.results;
  }

  @override
  Future<LocationItem?> reverseGeocode({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await _dioClient.get<Map<String, dynamic>>(
        'https://api.bigdatacloud.net/data/reverse-geocode-client',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'localityLanguage': 'en',
        },
      );

      final data = response.data;
      if (data != null) {
        final rawCity = (data['city'] as String?)?.trim();
        final rawLocality = (data['locality'] as String?)?.trim();
        final rawSubdivision = (data['principalSubdivision'] as String?)?.trim();
        final country = (data['countryName'] as String?)?.trim() ??
            (data['countryCode'] as String?)?.trim() ??
            'GPS';

        final name = (rawCity != null && rawCity.isNotEmpty)
            ? rawCity
            : (rawLocality != null && rawLocality.isNotEmpty)
                ? rawLocality
                : (rawSubdivision != null && rawSubdivision.isNotEmpty)
                    ? rawSubdivision
                    : 'Current Location';

        return LocationItem(
          name: name,
          country: country,
          latitude: latitude,
          longitude: longitude,
          isCurrentLocation: true,
        );
      }
    } catch (_) {
      // Graceful fallback on network failure or rate limits
    }
    return null;
  }
}

/// Riverpod provider for [GeocodingRemoteDataSource].
final geocodingRemoteDataSourceProvider = Provider<GeocodingRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return GeocodingRemoteDataSourceImpl(dioClient: dioClient);
});
