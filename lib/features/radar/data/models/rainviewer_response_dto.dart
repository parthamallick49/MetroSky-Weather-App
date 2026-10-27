import '../../domain/entities/radar_frame.dart';

/// DTO parsing RainViewer's weather-maps.json response into [RadarTimeline].
class RainViewerResponseDto {
  RainViewerResponseDto({
    required this.host,
    required this.pastFrames,
    required this.nowcastFrames,
    required this.generatedAt,
  });

  factory RainViewerResponseDto.fromJson(Map<String, dynamic> json) {
    final host = json['host']?.toString() ?? 'https://tilecache.rainviewer.com';
    final radar = json['radar'] as Map<String, dynamic>? ?? {};

    final pastList = (radar['past'] as List<dynamic>?) ?? [];
    final nowcastList = (radar['nowcast'] as List<dynamic>?) ?? [];

    final past = pastList.map((item) {
      final map = item as Map<String, dynamic>;
      return RadarFrame(
        timestamp: (map['time'] as num?)?.toInt() ?? 0,
        path: map['path']?.toString() ?? '',
        isNowcast: false,
      );
    }).toList();

    final nowcast = nowcastList.map((item) {
      final map = item as Map<String, dynamic>;
      return RadarFrame(
        timestamp: (map['time'] as num?)?.toInt() ?? 0,
        path: map['path']?.toString() ?? '',
        isNowcast: true,
      );
    }).toList();

    final generatedSec = (json['generated'] as num?)?.toInt() ?? 0;

    return RainViewerResponseDto(
      host: host,
      pastFrames: past,
      nowcastFrames: nowcast,
      generatedAt: DateTime.fromMillisecondsSinceEpoch(generatedSec * 1000, isUtc: true),
    );
  }

  final String host;
  final List<RadarFrame> pastFrames;
  final List<RadarFrame> nowcastFrames;
  final DateTime generatedAt;

  RadarTimeline toDomain() {
    return RadarTimeline(
      host: host,
      pastFrames: pastFrames,
      nowcastFrames: nowcastFrames,
      generatedAt: generatedAt,
    );
  }
}
