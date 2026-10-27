import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/widgets/app_glass_card.dart';
import '../../../domain/entities/air_quality.dart';

/// Bento card displaying Air Quality Index (AQI), pollutant metrics, and health advice.
class AirQualityCard extends StatelessWidget {
  const AirQualityCard({
    super.key,
    required this.airQuality,
  });

  final AirQuality airQuality;

  Color _getAqiColor(AqiLevel level) {
    switch (level) {
      case AqiLevel.good:
        return AppColors.aqiGood;
      case AqiLevel.fair:
        return AppColors.aqiModerate;
      case AqiLevel.moderate:
        return AppColors.aqiUnhealthySensitive;
      case AqiLevel.poor:
        return AppColors.aqiUnhealthy;
      case AqiLevel.veryPoor:
        return AppColors.aqiVeryUnhealthy;
      case AqiLevel.hazardous:
        return AppColors.aqiHazardous;
    }
  }

  @override
  Widget build(BuildContext context) {
    final aqi = airQuality.usAqi;
    final level = airQuality.level;
    final color = _getAqiColor(level);
    final ratio = (aqi / 300.0).clamp(0.0, 1.0);

    return AppGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Header
          const Row(
            children: [
              Icon(LucideIcons.leaf, size: 14.0, color: AppColors.textTertiary),
              SizedBox(width: 6.0),
              Text('AIR QUALITY', style: AppTypography.cardHeader),
            ],
          ),

          // Main AQI Value & Level
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$aqi',
                style: AppTypography.metricValue,
              ),
              Text(
                airQuality.statusText,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),

          // Spectrum Bar with Indicator
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      Container(
                        height: 5.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.aqiGood,
                              AppColors.aqiModerate,
                              AppColors.aqiUnhealthySensitive,
                              AppColors.aqiUnhealthy,
                              AppColors.aqiVeryUnhealthy,
                              AppColors.aqiHazardous,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: (constraints.maxWidth - 10.0) * ratio,
                        top: -2.5,
                        child: Container(
                          width: 10.0,
                          height: 10.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 4.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PM2.5: ${airQuality.pm25.toStringAsFixed(1)} µg/m³',
                    style: const TextStyle(fontSize: 11.0, color: AppColors.textTertiary),
                  ),
                  Text(
                    'PM10: ${airQuality.pm10.toStringAsFixed(1)} µg/m³',
                    style: const TextStyle(fontSize: 11.0, color: AppColors.textTertiary),
                  ),
                ],
              ),
            ],
          ),

          // Recommendation text
          Text(
            aqi <= 50
                ? 'Air quality is satisfactory and poses little to no health risk.'
                : 'Sensitive individuals should reduce prolonged outdoor exertion.',
            style: AppTypography.cardSummary,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
