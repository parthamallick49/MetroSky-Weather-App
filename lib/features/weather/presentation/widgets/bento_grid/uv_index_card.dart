import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/widgets/app_glass_card.dart';

/// Bento card displaying UV Index with horizontal spectrum bar and safety advice.
class UvIndexCard extends StatelessWidget {
  const UvIndexCard({
    super.key,
    required this.uvIndex,
  });

  final double uvIndex;

  String _getUvCategory(double uv) {
    if (uv <= 2) return 'Low';
    if (uv <= 5) return 'Moderate';
    if (uv <= 7) return 'High';
    if (uv <= 10) return 'Very High';
    return 'Extreme';
  }

  Color _getUvColor(double uv) {
    if (uv <= 2) return AppColors.uvLow;
    if (uv <= 5) return AppColors.uvModerate;
    if (uv <= 7) return AppColors.uvHigh;
    if (uv <= 10) return AppColors.uvVeryHigh;
    return AppColors.uvExtreme;
  }

  @override
  Widget build(BuildContext context) {
    final category = _getUvCategory(uvIndex);
    final color = _getUvColor(uvIndex);
    final ratio = (uvIndex / 12.0).clamp(0.0, 1.0);

    return AppGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Header
          const Row(
            children: [
              Icon(LucideIcons.sun, size: 14.0, color: AppColors.textTertiary),
              SizedBox(width: 6.0),
              Text('UV INDEX', style: AppTypography.cardHeader),
            ],
          ),

          // Main Value
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                uvIndex.toStringAsFixed(1),
                style: AppTypography.metricValue,
              ),
              Text(
                category,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),

          // Visual Spectrum Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      // Gradient spectrum bar
                      Container(
                        height: 5.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.uvLow,
                              AppColors.uvModerate,
                              AppColors.uvHigh,
                              AppColors.uvVeryHigh,
                              AppColors.uvExtreme,
                            ],
                          ),
                        ),
                      ),
                      // Position indicator dot
                      Positioned(
                        left: (constraints.maxWidth - 10.0) * ratio,
                        top: -2.5,
                        child: Container(
                          width: 10.0,
                          height: 10.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 4.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 8.0),
              Text(
                uvIndex > 5
                    ? 'Protection required. Seek shade during midday.'
                    : 'Low risk today. No protection required.',
                style: AppTypography.cardSummary,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
