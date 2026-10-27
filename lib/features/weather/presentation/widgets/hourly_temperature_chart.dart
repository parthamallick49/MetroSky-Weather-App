import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constants/wmo_weather_codes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/temperature_formatter.dart';
import '../../../../core/widgets/app_glass_card.dart';
import '../../../settings/domain/entities/user_preferences.dart';
import '../../../settings/presentation/controllers/settings_controller.dart';
import '../../domain/entities/hourly_weather.dart';

/// 24-Hour horizontal hourly forecast bar with precipitation probability and temperature trends.
class HourlyTemperatureChart extends ConsumerWidget {
  const HourlyTemperatureChart({
    super.key,
    required this.hourlyForecasts,
    this.maxHours = 24,
  });

  final List<HourlyWeather> hourlyForecasts;
  final int maxHours;

  IconData _getIconForCategory(WeatherConditionCategory category, bool isDay) {
    switch (category) {
      case WeatherConditionCategory.clear:
        return isDay ? LucideIcons.sun : LucideIcons.moon;
      case WeatherConditionCategory.partlyCloudy:
        return isDay ? LucideIcons.cloudSun : LucideIcons.cloudMoon;
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
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(userPreferencesProvider);
    final isFahrenheit = preferences.temperatureUnit == TemperatureUnit.fahrenheit;
    final displayList = hourlyForecasts.take(maxHours).toList();
    final now = DateTime.now();

    return AppGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          const Row(
            children: [
              Icon(
                LucideIcons.clock,
                size: 14.0,
                color: AppColors.textTertiary,
              ),
              SizedBox(width: 6.0),
              Text(
                'HOURLY FORECAST',
                style: AppTypography.cardHeader,
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // Horizontal Hourly List
          SizedBox(
            height: 124.0,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: displayList.length,
              separatorBuilder: (context, index) => const SizedBox(width: 18.0),
              itemBuilder: (context, index) {
                final item = displayList[index];
                final category = WmoWeatherCode.getCategory(item.weatherCode);
                final icon = _getIconForCategory(category, item.isDay);
                final isCurrentHour = index == 0;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Time label
                    Text(
                      item.time.toHourlyLabel(now: now),
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: isCurrentHour ? FontWeight.w600 : FontWeight.w400,
                        color: isCurrentHour ? Colors.white : AppColors.textSecondary,
                      ),
                    ),

                    // Condition Icon
                    Icon(
                      icon,
                      size: 24.0,
                      color: item.isDay && category == WeatherConditionCategory.clear
                          ? const Color(0xFFFFD54F) // warm sun gold
                          : Colors.white,
                    ),

                    // Precipitation Probability
                    SizedBox(
                      height: 16.0,
                      child: item.precipitationProbability > 0
                          ? Text(
                              '${item.precipitationProbability}%',
                              style: const TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF64B5F6), // soft rain blue
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),

                    // Hourly Temperature
                    Text(
                      TemperatureFormatter.format(item.temperature, isFahrenheit: isFahrenheit),
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
