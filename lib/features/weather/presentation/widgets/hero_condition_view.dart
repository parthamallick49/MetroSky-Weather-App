import 'package:flutter/material.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/temperature_formatter.dart';
import '../../domain/entities/current_weather.dart';
import '../../domain/entities/daily_forecast.dart';

/// Hero header view displaying location, massive temperature, condition, and high/low range.
class HeroConditionView extends StatelessWidget {
  const HeroConditionView({
    super.key,
    required this.cityName,
    required this.current,
    this.todayDaily,
  });

  final String cityName;
  final CurrentWeather current;
  final DailyForecast? todayDaily;

  @override
  Widget build(BuildContext context) {
    final highTemp = todayDaily?.maxTemperature ?? current.temperature;
    final lowTemp = todayDaily?.minTemperature ?? current.temperature;
    final rangeText = TemperatureFormatter.formatRange(highTemp, lowTemp);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 12.0),
        // City Name
        Text(
          cityName,
          style: AppTypography.heroLocation,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4.0),

        // Hero Temperature Display
        Text(
          TemperatureFormatter.format(current.temperature),
          style: AppTypography.displayTemp,
          textAlign: TextAlign.center,
        ),

        // Condition Subtitle
        Text(
          current.conditionText,
          style: AppTypography.conditionSubtitle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4.0),

        // High / Low Range & Feels Like
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              rangeText,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12.0),
            Text(
              'Feels like ${TemperatureFormatter.format(current.apparentTemperature)}',
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
