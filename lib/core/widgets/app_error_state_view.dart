import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'app_glass_card.dart';

/// Globally reusable error state view displaying an informative message and a retry action.
class AppErrorStateView extends StatelessWidget {
  const AppErrorStateView({
    super.key,
    required this.message,
    this.title = 'Unable to Load Weather',
    this.onRetry,
    this.icon = LucideIcons.cloudOff,
  });

  final String title;
  final String message;
  final VoidCallback? onRetry;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: AppGlassCard(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64.0,
                height: 64.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x26FF5252), // 15% red tint
                ),
                child: Icon(
                  icon,
                  size: 32.0,
                  color: const Color(0xFFFF5252),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTypography.cardSummary,
              ),
              if (onRetry != null) ...[
                const SizedBox(height: 24.0),
                ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(LucideIcons.refreshCw, size: 16.0),
                  label: const Text('Try Again'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
