import 'package:flutter/material.dart';

/// Semantic color palette for glassmorphism, weather conditions, and celestial skies.
class AppColors {
  AppColors._();

  // Glassmorphic Surface Colors
  static const Color glassSurfaceDark = Color(0x1AFFFFFF); // 10% white
  static const Color glassSurfaceActive = Color(0x33FFFFFF); // 20% white
  static const Color glassBorderLight = Color(0x33FFFFFF); // 20% white
  static const Color glassBorderSubtle = Color(0x1AFFFFFF); // 10% white
  static const Color glassBorderHighlight = Color(0x66FFFFFF); // 40% white

  // Sky Gradients (Day, Twilight, Night)
  static const Color skyDayTop = Color(0xFF1E5BB8);
  static const Color skyDayBottom = Color(0xFF5995E2);

  static const Color skyTwilightTop = Color(0xFF2C1B4D);
  static const Color skyTwilightBottom = Color(0xFFC77966);

  static const Color skyNightTop = Color(0xFF0B0D1B);
  static const Color skyNightBottom = Color(0xFF181B34);

  // High-Contrast Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xB3FFFFFF); // 70% white
  static const Color textTertiary = Color(0x80FFFFFF); // 50% white

  // Metric & Status Colors
  static const Color uvLow = Color(0xFF4CAF50);
  static const Color uvModerate = Color(0xFFFFEB3B);
  static const Color uvHigh = Color(0xFFFF9800);
  static const Color uvVeryHigh = Color(0xFFF44336);
  static const Color uvExtreme = Color(0xFF9C27B0);

  static const Color aqiGood = Color(0xFF4CAF50);
  static const Color aqiModerate = Color(0xFFFFEB3B);
  static const Color aqiUnhealthySensitive = Color(0xFFFF9800);
  static const Color aqiUnhealthy = Color(0xFFF44336);
  static const Color aqiVeryUnhealthy = Color(0xFF9C27B0);
  static const Color aqiHazardous = Color(0xFF7E0023);

  // Temperature Spectrum
  static const Color tempFreezing = Color(0xFF29B6F6);
  static const Color tempCold = Color(0xFF4DD0E1);
  static const Color tempMild = Color(0xFF81C784);
  static const Color tempWarm = Color(0xFFFFB74D);
  static const Color tempHot = Color(0xFFFF7043);
  static const Color tempExtreme = Color(0xFFE53935);
}
