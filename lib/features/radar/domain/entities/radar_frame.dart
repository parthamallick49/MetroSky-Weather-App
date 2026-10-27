import 'package:freezed_annotation/freezed_annotation.dart';

part 'radar_frame.freezed.dart';
part 'radar_frame.g.dart';

/// Immutable domain model representing a single timestamped radar scan frame.
@freezed
class RadarFrame with _$RadarFrame {
  const RadarFrame._();

  const factory RadarFrame({
    required int timestamp,
    required String path,
    required bool isNowcast,
  }) = _RadarFrame;

  factory RadarFrame.fromJson(Map<String, dynamic> json) =>
      _$RadarFrameFromJson(json);

  /// Human-readable time representation of the radar scan (e.g., "12:40 PM").
  DateTime get dateTime =>
      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true).toLocal();

  /// Builds the complete 256x256 Slippy Map raster tile URL template for this frame.
  /// Color scheme 2 = universal meteorological palette with smooth interpolation.
  String getTileUrlTemplate(String host) {
    return '$host$path/256/{z}/{x}/{y}/2/1_1.png';
  }
}

/// Aggregated radar timeline combining historical radar passes and predictive nowcasts.
@freezed
class RadarTimeline with _$RadarTimeline {
  const RadarTimeline._();

  const factory RadarTimeline({
    required String host,
    required List<RadarFrame> pastFrames,
    required List<RadarFrame> nowcastFrames,
    required DateTime generatedAt,
  }) = _RadarTimeline;

  factory RadarTimeline.fromJson(Map<String, dynamic> json) =>
      _$RadarTimelineFromJson(json);

  /// Combined contiguous list of all past scans followed by future nowcast frames.
  List<RadarFrame> get allFrames => [...pastFrames, ...nowcastFrames];

  /// Total count of available frames.
  int get frameCount => pastFrames.length + nowcastFrames.length;
}
