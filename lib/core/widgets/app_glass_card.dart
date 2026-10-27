import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_glassmorphism.dart';

/// Globally reusable glassmorphic container utilizing [BackdropFilter] and subtle gradient borders.
class AppGlassCard extends StatelessWidget {
  const AppGlassCard({
    super.key,
    required this.child,
    this.borderRadius = AppGlassmorphism.cardRadius,
    this.blur = AppGlassmorphism.blurStandard,
    this.padding = AppGlassmorphism.cardPadding,
    this.margin,
    this.width,
    this.height,
    this.backgroundColor = AppColors.glassSurfaceDark,
    this.borderGradient = AppGlassmorphism.borderGradient,
    this.borderWidth = 1.0,
    this.onTap,
  });

  final Widget child;
  final double borderRadius;
  final double blur;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final Color backgroundColor;
  final Gradient? borderGradient;
  final double borderWidth;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Widget cardContent = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderGradient == null ? AppColors.glassBorderSubtle : Colors.transparent,
              width: borderWidth,
            ),
          ),
          child: child,
        ),
      ),
    );

    if (borderGradient != null) {
      cardContent = Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: borderGradient,
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F000000), // 12% black drop shadow
              blurRadius: 16.0,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: cardContent,
      );
    }

    if (onTap != null) {
      cardContent = Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          child: cardContent,
        ),
      );
    }

    if (margin != null) {
      return Padding(
        padding: margin!,
        child: cardContent,
      );
    }

    return cardContent;
  }
}
