import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/solar_calculator.dart';

/// Pure utility and widget painting dynamic celestial sky gradients based on solar elevation.
class DynamicSkyGradient {
  DynamicSkyGradient._();

  /// Calculates top and bottom gradient colors for a given [solarElevation].
  static ({Color top, Color bottom}) calculatePalette(double solarElevation) {
    if (solarElevation < -18.0) {
      // Night
      return (top: AppColors.skyNightTop, bottom: AppColors.skyNightBottom);
    } else if (solarElevation < 0.0) {
      // Twilight
      final t = (solarElevation + 18.0) / 18.0;
      return (
        top: Color.lerp(AppColors.skyNightTop, AppColors.skyTwilightTop, t) ??
            AppColors.skyTwilightTop,
        bottom: Color.lerp(
                AppColors.skyNightBottom, AppColors.skyTwilightBottom, t) ??
            AppColors.skyTwilightBottom,
      );
    } else if (solarElevation < 6.0) {
      // Golden Hour
      final t = solarElevation / 6.0;
      const goldenTop = Color(0xFF383C78);
      const goldenBottom = Color(0xFFF5A661);
      return (
        top: Color.lerp(AppColors.skyTwilightTop, goldenTop, t) ?? goldenTop,
        bottom: Color.lerp(AppColors.skyTwilightBottom, goldenBottom, t) ??
            goldenBottom,
      );
    } else {
      // Daytime
      final t = ((solarElevation - 6.0) / 24.0).clamp(0.0, 1.0);
      const goldenTop = Color(0xFF383C78);
      const goldenBottom = Color(0xFFF5A661);
      return (
        top: Color.lerp(goldenTop, AppColors.skyDayTop, t) ??
            AppColors.skyDayTop,
        bottom: Color.lerp(goldenBottom, AppColors.skyDayBottom, t) ??
            AppColors.skyDayBottom,
      );
    }
  }

  /// Returns a [LinearGradient] configured for the current [solarElevation].
  static LinearGradient getGradient(double solarElevation) {
    final palette = calculatePalette(solarElevation);
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [palette.top, palette.bottom],
    );
  }
}

/// A presentational widget rendering the dynamic celestial sky gradient.
class DynamicSkyBackground extends StatelessWidget {
  const DynamicSkyBackground({
    super.key,
    required this.solarPosition,
    this.child,
  });

  final SolarPosition solarPosition;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final gradient = DynamicSkyGradient.getGradient(solarPosition.elevationDegrees);

    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(gradient: gradient),
      child: child,
    );
  }
}
