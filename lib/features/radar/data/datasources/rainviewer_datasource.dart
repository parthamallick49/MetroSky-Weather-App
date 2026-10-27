import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/radar_frame.dart';
import '../models/rainviewer_response_dto.dart';

/// Remote data source fetching radar timeline metadata from RainViewer.
abstract class RainViewerDataSource {
  Future<RadarTimeline> getRadarTimeline();
}

class RainViewerDataSourceImpl implements RainViewerDataSource {
  RainViewerDataSourceImpl({required DioClient dioClient})
      : _dioClient = dioClient;

  final DioClient _dioClient;

  @override
  Future<RadarTimeline> getRadarTimeline() async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      '${ApiEndpoints.rainViewerBaseUrl}/weather-maps.json',
    );

    final dto = RainViewerResponseDto.fromJson(response.data ?? {});
    return dto.toDomain();
  }
}

/// Riverpod provider for [RainViewerDataSource].
final rainViewerDataSourceProvider = Provider<RainViewerDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return RainViewerDataSourceImpl(dioClient: dioClient);
});
