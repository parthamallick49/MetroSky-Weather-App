import '../entities/radar_frame.dart';

/// Abstract contract for fetching RainViewer radar maps and tile frames.
abstract class RadarRepository {
  /// Fetches the latest radar timeline including past scans and nowcasts.
  Future<RadarTimeline> getRadarTimeline();
}
