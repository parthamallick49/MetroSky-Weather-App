import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/radar/data/models/rainviewer_response_dto.dart';

void main() {
  group('RainViewerResponseDto', () {
    test('parses rainviewer weather-maps.json into RadarTimeline domain entity', () {
      final json = {
        'version': '2.0',
        'generated': 1729000000,
        'host': 'https://tilecache.rainviewer.com',
        'radar': {
          'past': [
            {'time': 1728994000, 'path': '/v2/radar/1728994000'},
            {'time': 1728994600, 'path': '/v2/radar/1728994600'},
          ],
          'nowcast': [
            {'time': 1729001200, 'path': '/v2/radar/1729001200'},
          ],
        },
      };

      final dto = RainViewerResponseDto.fromJson(json);
      final timeline = dto.toDomain();

      expect(timeline.host, 'https://tilecache.rainviewer.com');
      expect(timeline.pastFrames.length, 2);
      expect(timeline.nowcastFrames.length, 1);
      expect(timeline.frameCount, 3);

      final firstPast = timeline.pastFrames.first;
      expect(firstPast.isNowcast, isFalse);
      expect(firstPast.timestamp, 1728994000);
      expect(
        firstPast.getTileUrlTemplate(timeline.host),
        'https://tilecache.rainviewer.com/v2/radar/1728994000/256/{z}/{x}/{y}/2/1_1.png',
      );

      final nowcast = timeline.nowcastFrames.first;
      expect(nowcast.isNowcast, isTrue);
      expect(nowcast.timestamp, 1729001200);
    });
  });
}
