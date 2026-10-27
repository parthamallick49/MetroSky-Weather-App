import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constants/wmo_weather_codes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/temperature_formatter.dart';
import '../../../../core/widgets/app_glass_card.dart';
import '../../domain/entities/daily_forecast.dart';

/// 7-Day forecast list featuring Apple Weather-style temperature gradient range bars.
class DailyForecastList extends StatelessWidget {
  const DailyForecastList({
    super.key,
    required this.dailyForecasts,
  });

  final List<DailyForecast> dailyForecasts;

  IconData _getIconForCategory(WeatherConditionCategory category) {
    switch (category) {
      case WeatherConditionCategory.clear:
        return LucideIcons.sun;
      case WeatherConditionCategory.partlyCloudy:
        return LucideIcons.cloudSun;
      case WeatherConditionCategory.overcast:
        return LucideIcons.cloud;
      case WeatherConditionCategory.fog:
        return LucideIcons.cloudFog;
      case WeatherConditionCategory.drizzle:
        return LucideIcons.cloudDrizzle;
      case WeatherConditionCategory.rain:
        return LucideIcons.cloudRain;
      case WeatherConditionCategory.snow:
        return LucideIcons.cloudSnow;
      case WeatherConditionCategory.thunderstorm:
        return LucideIcons.cloudLightning;
      case WeatherConditionCategory.unknown:
        return LucideIcons.cloud;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dailyForecasts.isEmpty) return const SizedBox.shrink();

    // 1. Calculate the week's global minimum and maximum bounds
    var weekMin = double.infinity;
    var weekMax = -double.infinity;

    for (final day in dailyForecasts) {
      if (day.minTemperature < weekMin) weekMin = day.minTemperature;
      if (day.maxTemperature > weekMax) weekMax = day.maxTemperature;
    }

    final totalRange = math.max(1.0, weekMax - weekMin);
    final now = DateTime.now();

    return AppGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Row(
            children: [
              Icon(
                LucideIcons.calendar,
                size: 14.0,
                color: AppColors.textTertiary,
              ),
              SizedBox(width: 6.0),
              Text(
                '7-DAY FORECAST',
                style: AppTypography.cardHeader,
              ),
            ],
          ),
          const SizedBox(height: 12.0),

          // Daily Rows
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dailyForecasts.length,
            separatorBuilder: (context, index) => const Divider(
              color: Color(0x1AFFFFFF), // 10% white subtle divider
              height: 16.0,
            ),
            itemBuilder: (context, index) {
              final day = dailyForecasts[index];
              final category = WmoWeatherCode.getCategory(day.weatherCode);
              final icon = _getIconForCategory(category);

              // 2. Normalized range calculations for the Apple Weather range bar
              final startRatio = ((day.minTemperature - weekMin) / totalRange).clamp(0.0, 1.0);
              final widthRatio = ((day.maxTemperature - day.minTemperature) / totalRange).clamp(0.08, 1.0);

              return Row(
                children: [
                  // Day Label
                  SizedBox(
                    width: 68.0,
                    child: Text(
                      day.date.toDailyLabel(now: now),
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),

                  // Condition Icon
                  Icon(
                    icon,
                    size: 20.0,
                    color: category == WeatherConditionCategory.clear
                        ? const Color(0xFFFFD54F)
                        : Colors.white,
                  ),
                  const SizedBox(width: 14.0),

                  // Low Temperature
                  SizedBox(
                    width: 34.0,
                    child: Text(
                      TemperatureFormatter.format(day.minTemperature),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),

                  // Normalized Temperature Range Bar
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final barWidth = constraints.maxWidth;
                        final indicatorLeft = barWidth * startRatio;
                        final indicatorWidth = math.min(
                          barWidth - indicatorLeft,
                          math.max(12.0, barWidth * widthRatio),
                        );

                        return Stack(
                          children: [
                            // Background Track
                            Container(
                              height: 5.0,
                              decoration: BoxDecoration(
                                color: const Color(0x1FFFFFFF), // 12% white track
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                            ),

                            // Active Temperature Gradient Range Indicator
                            Positioned(
                              left: indicatorLeft,
                              width: indicatorWidth,
                              child: Container(
                                height: 5.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.0),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF4DD0E1), // Cool Cyan
                                      Color(0xFFFFB74D), // Warm Amber
                                      Color(0xFFFF7043), // Hot Coral
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10.0),

                  // High Temperature
                  SizedBox(
                    width: 34.0,
                    child: Text(
                      TemperatureFormatter.format(day.maxTemperature),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
