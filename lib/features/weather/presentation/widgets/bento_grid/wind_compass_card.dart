import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/widgets/app_glass_card.dart';

/// Bento card featuring a rotating compass rose and real-time wind metrics.
class WindCompassCard extends StatelessWidget {
  const WindCompassCard({
    super.key,
    required this.windSpeedKmh,
    required this.windDirectionDegrees,
  });

  final double windSpeedKmh;
  final double windDirectionDegrees;

  String _getCardinalDirection(double degrees) {
    const directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    final index = ((degrees + 22.5) % 360) ~/ 45;
    return directions[index];
  }

  @override
  Widget build(BuildContext context) {
    final cardinal = _getCardinalDirection(windDirectionDegrees);

    return AppGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Header
          const Row(
            children: [
              Icon(LucideIcons.wind, size: 14.0, color: AppColors.textTertiary),
              SizedBox(width: 6.0),
              Text('WIND', style: AppTypography.cardHeader),
            ],
          ),

          // Compass Rose & Direction Values Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Value display
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        windSpeedKmh.round().toString(),
                        style: AppTypography.metricValue,
                      ),
                      const SizedBox(width: 4.0),
                      const Text(
                        'km/h',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '$cardinal · ${windDirectionDegrees.round()}°',
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),

              // Animated Compass Rose Widget
              SizedBox(
                width: 68.0,
                height: 68.0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer Compass Ring with Cardinal Labels
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0x33FFFFFF),
                          width: 1.5,
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 4.0,
                      child: Text(
                        'N',
                        style: TextStyle(
                          fontSize: 9.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 4.0,
                      child: Text(
                        'S',
                        style: TextStyle(
                          fontSize: 9.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ),

                    // Rotating Arrow Needle
                    Transform.rotate(
                      angle: (windDirectionDegrees * math.pi / 180.0),
                      child: Container(
                        width: 4.0,
                        height: 48.0,
                        alignment: Alignment.topCenter,
                        child: const Icon(
                          LucideIcons.navigation,
                          size: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Summary Text
          Text(
            windSpeedKmh > 30.0
                ? 'Strong breeze. Gusts may affect outdoor activities.'
                : 'Gentle breeze today.',
            style: AppTypography.cardSummary,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
