import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_glassmorphism.dart';

/// Globally reusable glassmorphic circular icon button with blur and ripple feedback.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 44.0,
    this.iconSize = 20.0,
    this.iconColor = AppColors.textPrimary,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final double iconSize;
  final Color iconColor;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    Widget button = ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: AppGlassmorphism.blurStandard,
          sigmaY: AppGlassmorphism.blurStandard,
        ),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.glassSurfaceDark,
            border: Border.all(
              color: AppColors.glassBorderSubtle,
              width: 1.0,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onPressed,
              child: Center(
                child: Icon(
                  icon,
                  size: iconSize,
                  color: iconColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (tooltip != null) {
      button = Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }
}
