import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_glass_card.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../domain/entities/user_preferences.dart';
import '../controllers/settings_controller.dart';

/// Comprehensive settings screen for customizing units, graphics, and viewing data attributions.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(userPreferencesProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.skyNightTop,
      body: Stack(
        children: [
          // Ambient background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.skyNightTop,
                  AppColors.skyNightBottom,
                ],
              ),
            ),
          ),

          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // 1. Navigation App Bar
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppIconButton(
                          icon: LucideIcons.arrowLeft,
                          tooltip: 'Back',
                          onPressed: () => context.pop(),
                        ),
                        const Text(
                          'Settings',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 44.0), // Visual balance for back button
                      ],
                    ),
                  ),
                ),

                // 2. Units Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 8.0),
                    child: Text(
                      'UNITS',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.6),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: AppGlassCard(
                      child: Column(
                        children: [
                          _UnitOptionRow<TemperatureUnit>(
                            icon: LucideIcons.thermometer,
                            title: 'Temperature',
                            selected: preferences.temperatureUnit,
                            options: const [
                              (TemperatureUnit.celsius, '°C'),
                              (TemperatureUnit.fahrenheit, '°F'),
                            ],
                            onSelected: controller.setTemperatureUnit,
                          ),
                          const Divider(color: Colors.white12, height: 20.0),
                          _UnitOptionRow<WindSpeedUnit>(
                            icon: LucideIcons.wind,
                            title: 'Wind Speed',
                            selected: preferences.windSpeedUnit,
                            options: const [
                              (WindSpeedUnit.kmh, 'km/h'),
                              (WindSpeedUnit.mph, 'mph'),
                              (WindSpeedUnit.ms, 'm/s'),
                            ],
                            onSelected: controller.setWindSpeedUnit,
                          ),
                          const Divider(color: Colors.white12, height: 20.0),
                          _UnitOptionRow<PressureUnit>(
                            icon: LucideIcons.gauge,
                            title: 'Atmospheric Pressure',
                            selected: preferences.pressureUnit,
                            options: const [
                              (PressureUnit.hPa, 'hPa'),
                              (PressureUnit.inHg, 'inHg'),
                            ],
                            onSelected: controller.setPressureUnit,
                          ),
                          const Divider(color: Colors.white12, height: 20.0),
                          _UnitOptionRow<PrecipitationUnit>(
                            icon: LucideIcons.cloudRain,
                            title: 'Precipitation',
                            selected: preferences.precipitationUnit,
                            options: const [
                              (PrecipitationUnit.mm, 'mm'),
                              (PrecipitationUnit.inches, 'in'),
                            ],
                            onSelected: controller.setPrecipitationUnit,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // 3. Performance & Visual Engine Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 8.0),
                    child: Text(
                      'PERFORMANCE & GRAPHICS',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.6),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: AppGlassCard(
                      child: Column(
                        children: [
                          _ToggleSettingTile(
                            icon: LucideIcons.sparkles,
                            title: 'Impeller Fragment Shaders',
                            subtitle: 'Enables GPU ambient shaders for realistic weather backdrops',
                            value: preferences.enableShaders,
                            onChanged: controller.toggleShaders,
                          ),
                          const Divider(color: Colors.white12, height: 20.0),
                          _ToggleSettingTile(
                            icon: LucideIcons.cloudSnow,
                            title: 'Weather Particle Canvas',
                            subtitle: 'Render live falling rain streaks and snow particles',
                            value: preferences.enableParticles,
                            onChanged: controller.toggleParticles,
                          ),
                          const Divider(color: Colors.white12, height: 20.0),
                          _ToggleSettingTile(
                            icon: LucideIcons.vibrate,
                            title: 'Tactile Haptic Feedback',
                            subtitle: 'Subtle micro-vibrations when scrubbing radar or reordering cities',
                            value: preferences.enableHaptics,
                            onChanged: controller.toggleHaptics,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // 4. Data Sources & Attribution Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 8.0),
                    child: Text(
                      'DATA SOURCES & ATTRIBUTION',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.6),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: AppGlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _AttributionTile(
                            title: 'Weather & Air Quality Data',
                            source: 'Open-Meteo (Non-Commercial CC-BY 4.0)',
                          ),
                          Divider(color: Colors.white12, height: 16.0),
                          _AttributionTile(
                            title: 'Weather Radar Tiles',
                            source: 'RainViewer Real-time Weather Radar API',
                          ),
                          Divider(color: Colors.white12, height: 16.0),
                          _AttributionTile(
                            title: 'Mapping Vector Basemap',
                            source: 'MapLibre GL & Carto Dark Tile Service',
                          ),
                          Divider(color: Colors.white12, height: 16.0),
                          _AttributionTile(
                            title: 'Icons & Aesthetics',
                            source: 'Lucide Icons & Apple Weather Inspired Aesthetic',
                          ),
                          Divider(color: Colors.white12, height: 16.0),
                          _AttributionTile(
                            title: 'MetroSky App',
                            source: 'Version 1.0.0 (Build 1) · Production Ready',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: 48.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UnitOptionRow<T> extends StatelessWidget {
  final IconData icon;
  final String title;
  final T selected;
  final List<(T value, String label)> options;
  final ValueChanged<T> onSelected;

  const _UnitOptionRow({
    required this.icon,
    required this.title,
    required this.selected,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20.0, color: Colors.white70),
        const SizedBox(width: 12.0),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: options.map((opt) {
              final isCurrent = opt.$1 == selected;
              return GestureDetector(
                onTap: () => onSelected(opt.$1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: isCurrent ? Colors.white.withValues(alpha: 0.25) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    opt.$2,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                      color: isCurrent ? Colors.white : Colors.white60,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _ToggleSettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleSettingTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 20.0, color: Colors.white70),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12.0),
        Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeTrackColor: const Color(0xFF29B6F6),
        ),
      ],
    );
  }
}

class _AttributionTile extends StatelessWidget {
  final String title;
  final String source;

  const _AttributionTile({
    required this.title,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          source,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
