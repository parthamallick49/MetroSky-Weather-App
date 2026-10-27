import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/location/data/models/geocoding_response_dto.dart';

void main() {
  group('GeocodingResponseDto', () {
    test('parses open-meteo geocoding search results cleanly', () {
      final json = {
        'results': [
          {
            'id': 2988507,
            'name': 'Paris',
            'latitude': 48.85341,
            'longitude': 2.3488,
            'country': 'France',
            'admin1': 'Île-de-France',
            'timezone': 'Europe/Paris',
          },
          {
            'id': 1850147,
            'name': 'Tokyo',
            'latitude': 35.6762,
            'longitude': 139.6503,
            'country': 'Japan',
            'admin1': 'Tokyo',
            'timezone': 'Asia/Tokyo',
          },
        ],
      };

      final dto = GeocodingResponseDto.fromJson(json);

      expect(dto.results.length, 2);

      final paris = dto.results.first;
      expect(paris.name, 'Paris');
      expect(paris.latitude, 48.85341);
      expect(paris.longitude, 2.3488);
      expect(paris.country, 'France');
      expect(paris.admin1, 'Île-de-France');
      expect(paris.subtitle, 'Île-de-France, France');

      final tokyo = dto.results.last;
      expect(tokyo.name, 'Tokyo');
      expect(tokyo.country, 'Japan');
      expect(tokyo.subtitle, 'Tokyo, Japan');
    });

    test('handles empty results list gracefully', () {
      final dto = GeocodingResponseDto.fromJson({});
      expect(dto.results, isEmpty);
    });
  });
}
