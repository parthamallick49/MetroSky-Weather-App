import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Geometry, blur tokens, and decorative styling for the glassmorphism design system.
class AppGlassmorphism {
  AppGlassmorphism._();

  /// Standard Gaussian blur intensity for glass cards.
  static const double blurStandard = 16.0;

  /// High Gaussian blur intensity for modals and navigation bars.
  static const double blurHigh = 24.0;

  /// Standard border radius for metric cards and bento containers.
  static const double cardRadius = 24.0;

  /// Compact border radius for mini badges, chips, and small cards.
  static const double badgeRadius = 12.0;

  /// Standard padding inside glass cards.
  static const EdgeInsets cardPadding = EdgeInsets.all(16.0);

  /// Linear gradient border for cards giving a tactile edge refraction effect.
  static const LinearGradient borderGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.glassBorderHighlight,
      AppColors.glassBorderSubtle,
    ],
  );

  /// Surface decoration for glassmorphic elements.
  static BoxDecoration glassDecoration({
    double radius = cardRadius,
    Color surfaceColor = AppColors.glassSurfaceDark,
    Gradient? customBorderGradient,
    double borderWidth = 1.0,
  }) {
    return BoxDecoration(
      color: surfaceColor,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: customBorderGradient == null ? AppColors.glassBorderSubtle : Colors.transparent,
        width: borderWidth,
      ),
      boxShadow: const [
        BoxShadow(
          color: Color(0x1F000000), // 12% black shadow
          blurRadius: 16.0,
          offset: Offset(0, 8),
        ),
      ],
    );
  }
}
