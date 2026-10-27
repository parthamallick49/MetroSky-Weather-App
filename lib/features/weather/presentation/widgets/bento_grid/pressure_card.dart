import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/utils/temperature_formatter.dart';
import '../../../../../core/widgets/app_glass_card.dart';

/// Bento card displaying surface barometric pressure and humidity/dew point.
class PressureCard extends StatelessWidget {
  const PressureCard({
    super.key,
    required this.surfacePressureHpa,
    required this.relativeHumidity,
    required this.dewPointCelsius,
  });

  final double surfacePressureHpa;
  final int relativeHumidity;
  final double dewPointCelsius;

  String _getPressureTendency(double hpa) {
    if (hpa > 1020) return 'High Pressure · Clear';
    if (hpa < 1005) return 'Low Pressure · Stormy';
    return 'Normal Pressure · Steady';
  }

  @override
  Widget build(BuildContext context) {
    final tendency = _getPressureTendency(surfacePressureHpa);

    return AppGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Header
          const Row(
            children: [
              Icon(LucideIcons.gauge, size: 14.0, color: AppColors.textTertiary),
              SizedBox(width: 6.0),
              Text('PRESSURE & HUMIDITY', style: AppTypography.cardHeader),
            ],
          ),

          // Primary Pressure Value
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                surfacePressureHpa.round().toString(),
                style: AppTypography.metricValue,
              ),
              const SizedBox(width: 4.0),
              const Text(
                'hPa',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          // Humidity & Dew Point Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Humidity', style: TextStyle(fontSize: 12.0, color: AppColors.textTertiary)),
                  Text(
                    '$relativeHumidity%',
                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Dew Point', style: TextStyle(fontSize: 12.0, color: AppColors.textTertiary)),
                  Text(
                    TemperatureFormatter.format(dewPointCelsius),
                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),

          // Summary
          Text(
            tendency,
            style: AppTypography.cardSummary,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
