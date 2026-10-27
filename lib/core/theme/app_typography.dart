import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Unified high-contrast typography tokens for the weather application.
class AppTypography {
  AppTypography._();

  /// Massive hero temperature display (e.g., "72°").
  static const TextStyle displayTemp = TextStyle(
    fontSize: 92.0,
    fontWeight: FontWeight.w200,
    letterSpacing: -2.0,
    color: AppColors.textPrimary,
    height: 1.0,
  );

  /// Medium hero temperature display.
  static const TextStyle headlineTemp = TextStyle(
    fontSize: 48.0,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.0,
    color: AppColors.textPrimary,
    height: 1.1,
  );

  /// City or destination title on hero dashboard.
  static const TextStyle heroLocation = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
  );

  /// Current condition subtitle (e.g., "Partly Cloudy").
  static const TextStyle conditionSubtitle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  /// Bento card titles (e.g., "UV INDEX", "WIND").
  static const TextStyle cardHeader = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.8,
    color: AppColors.textTertiary,
  );

  /// Large metric value inside bento cards (e.g., "14 km/h", "1013 hPa").
  static const TextStyle metricValue = TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  /// Explanatory summary text inside bento cards.
  static const TextStyle cardSummary = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.3,
  );
}
