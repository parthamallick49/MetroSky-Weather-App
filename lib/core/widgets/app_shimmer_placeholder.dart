import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_glassmorphism.dart';

/// Globally reusable shimmer skeleton placeholder widget.
class AppShimmerPlaceholder extends StatelessWidget {
  const AppShimmerPlaceholder({
    super.key,
    this.width,
    this.height,
    this.borderRadius = AppGlassmorphism.badgeRadius,
    this.baseColor = const Color(0x1AFFFFFF),
    this.highlightColor = const Color(0x33FFFFFF),
  });

  /// Factory constructor for circular avatar/icon placeholders.
  factory AppShimmerPlaceholder.circular({
    Key? key,
    required double size,
  }) {
    return AppShimmerPlaceholder(
      key: key,
      width: size,
      height: size,
      borderRadius: size / 2,
    );
  }

  final double? width;
  final double? height;
  final double borderRadius;
  final Color baseColor;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
