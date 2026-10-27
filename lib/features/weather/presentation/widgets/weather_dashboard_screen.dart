import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_glass_card.dart';
import '../../../../core/widgets/app_icon_button.dart';

/// Main weather forecast dashboard screen.
class WeatherDashboardScreen extends StatelessWidget {
  const WeatherDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.skyNightTop,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIconButton(
                    icon: LucideIcons.menu,
                    tooltip: 'Locations',
                    onPressed: () {},
                  ),
                  const Text(
                    'Weather',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  AppIconButton(
                    icon: LucideIcons.settings,
                    tooltip: 'Settings',
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              const AppGlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Core Foundation Initialized',
                      style: AppTypography.conditionSubtitle,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Glassmorphism, Dio networking with retry interceptors, Hive CE persistence, and pure astronomical math utilities are ready for Phase 2.',
                      style: AppTypography.cardSummary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
