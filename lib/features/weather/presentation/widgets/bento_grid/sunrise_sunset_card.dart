import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/utils/date_formatter.dart';
import '../../../../../core/widgets/app_glass_card.dart';

/// Bento card visualizing the solar arc, current sun elevation, and sunrise/sunset times.
class SunriseSunsetCard extends StatelessWidget {
  const SunriseSunsetCard({
    super.key,
    required this.sunrise,
    required this.sunset,
    this.now,
  });

  final DateTime sunrise;
  final DateTime sunset;
  final DateTime? now;

  @override
  Widget build(BuildContext context) {
    final currentTime = now ?? DateTime.now();
    final isDay = currentTime.isAfter(sunrise) && currentTime.isBefore(sunset);

    // Calculate daylight progress percentage (0.0 to 1.0)
    final totalDaylightMinutes = sunset.difference(sunrise).inMinutes;
    final elapsedMinutes = currentTime.difference(sunrise).inMinutes;
    final progress = totalDaylightMinutes > 0
        ? (elapsedMinutes / totalDaylightMinutes).clamp(0.0, 1.0)
        : 0.5;

    // Remaining time string
    final String statusString;
    if (isDay) {
      final remaining = sunset.difference(currentTime);
      final hours = remaining.inHours;
      final minutes = remaining.inMinutes % 60;
      statusString = 'Sunset in ${hours}h ${minutes}m';
    } else {
      final nextSunrise = currentTime.isBefore(sunrise)
          ? sunrise
          : sunrise.add(const Duration(days: 1));
      final remaining = nextSunrise.difference(currentTime);
      final hours = remaining.inHours;
      final minutes = remaining.inMinutes % 60;
      statusString = 'Sunrise in ${hours}h ${minutes}m';
    }

    return AppGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Header
          const Row(
            children: [
              Icon(LucideIcons.sunrise, size: 14.0, color: AppColors.textTertiary),
              SizedBox(width: 6.0),
              Text('SUNRISE & SUNSET', style: AppTypography.cardHeader),
            ],
          ),

          // Primary event time
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isDay ? sunset.toTimeString() : sunrise.toTimeString(),
                style: AppTypography.metricValue,
              ),
              Text(
                isDay ? 'Sunset' : 'Sunrise',
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          // Solar Arc Custom Visualizer
          Column(
            children: [
              SizedBox(
                height: 38.0,
                width: double.infinity,
                child: CustomPaint(
                  painter: _SolarArcPainter(progress: progress, isDay: isDay),
                ),
              ),
              const SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rise: ${sunrise.toTimeString()}',
                    style: const TextStyle(fontSize: 11.0, color: AppColors.textTertiary),
                  ),
                  Text(
                    'Set: ${sunset.toTimeString()}',
                    style: const TextStyle(fontSize: 11.0, color: AppColors.textTertiary),
                  ),
                ],
              ),
            ],
          ),

          // Countdown status
          Text(
            statusString,
            style: AppTypography.cardSummary,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _SolarArcPainter extends CustomPainter {
  _SolarArcPainter({required this.progress, required this.isDay});

  final double progress;
  final bool isDay;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(
        size.width / 2,
        -size.height * 0.4,
        size.width,
        size.height,
      );

    // Background Arc Track
    final trackPaint = Paint()
      ..color = const Color(0x33FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawPath(path, trackPaint);

    // Sun Marker Dot position on quadratic bezier: B(t) = (1-t)^2 P0 + 2(1-t)t P1 + t^2 P2
    final t = progress;
    final p0 = Offset(0, size.height);
    final p1 = Offset(size.width / 2, -size.height * 0.4);
    final p2 = Offset(size.width, size.height);

    final x = (1 - t) * (1 - t) * p0.dx + 2 * (1 - t) * t * p1.dx + t * t * p2.dx;
    final y = (1 - t) * (1 - t) * p0.dy + 2 * (1 - t) * t * p1.dy + t * t * p2.dy;

    final sunPaint = Paint()
      ..color = isDay ? const Color(0xFFFFD54F) : const Color(0xFF90CAF9)
      ..style = PaintingStyle.fill;

    // Glowing sun halo
    canvas.drawCircle(Offset(x, y), 7.0, Paint()..color = sunPaint.color.withValues(alpha: 0.3));
    // Core sun dot
    canvas.drawCircle(Offset(x, y), 4.5, sunPaint);
  }

  @override
  bool shouldRepaint(covariant _SolarArcPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.isDay != isDay;
  }
}
