import '../../domain/entities/air_quality.dart';

/// DTO parser for Open-Meteo Air Quality API response.
class OpenMeteoAirQualityResponse {
  OpenMeteoAirQualityResponse({
    required this.latitude,
    required this.longitude,
    required this.airQuality,
  });

  factory OpenMeteoAirQualityResponse.fromJson(Map<String, dynamic> json) {
    final current = json['current'] as Map<String, dynamic>? ?? {};

    return OpenMeteoAirQualityResponse(
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      airQuality: AirQuality(
        europeanAqi: (current['european_aqi'] as num?)?.toInt() ?? 0,
        usAqi: (current['us_aqi'] as num?)?.toInt() ?? 0,
        pm10: (current['pm10'] as num?)?.toDouble() ?? 0.0,
        pm25: (current['pm2_5'] as num?)?.toDouble() ?? 0.0,
        carbonMonoxide:
            (current['carbon_monoxide'] as num?)?.toDouble() ?? 0.0,
        nitrogenDioxide:
            (current['nitrogen_dioxide'] as num?)?.toDouble() ?? 0.0,
        sulphurDioxide:
            (current['sulphur_dioxide'] as num?)?.toDouble() ?? 0.0,
        ozone: (current['ozone'] as num?)?.toDouble() ?? 0.0,
      ),
    );
  }

  final double latitude;
  final double longitude;
  final AirQuality airQuality;
}
