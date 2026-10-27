import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// Global application theme definition.
class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.skyNightTop,
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        onPrimary: Colors.black,
        surface: AppColors.skyNightBottom,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: const TextTheme(
        displayLarge: AppTypography.displayTemp,
        headlineLarge: AppTypography.heroLocation,
        titleMedium: AppTypography.conditionSubtitle,
        bodyMedium: AppTypography.cardSummary,
        labelSmall: AppTypography.cardHeader,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.heroLocation,
      ),
    );
  }
}
