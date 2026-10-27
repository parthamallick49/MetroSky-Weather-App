import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/location_item.dart';
import '../models/geocoding_response_dto.dart';

/// Remote data source executing search queries against Open-Meteo Geocoding API.
abstract class GeocodingRemoteDataSource {
  Future<List<LocationItem>> searchCities(String query);
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
}

/// Riverpod provider for [GeocodingRemoteDataSource].
final geocodingRemoteDataSourceProvider = Provider<GeocodingRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return GeocodingRemoteDataSourceImpl(dioClient: dioClient);
});
