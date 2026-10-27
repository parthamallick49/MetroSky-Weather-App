import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_error_state_view.dart';
import '../../../../core/widgets/app_glass_card.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../core/widgets/app_shimmer_placeholder.dart';
import '../../../weather/presentation/controllers/weather_controller.dart';
import '../../domain/entities/location_item.dart';
import '../controllers/saved_locations_controller.dart';
import 'city_search_sheet.dart';
import 'reorderable_city_card.dart';

/// Screen managing user favorite locations, reordering, GPS detection, and search.
class LocationManagementScreen extends ConsumerWidget {
  const LocationManagementScreen({super.key});

  void _selectLocation(BuildContext context, WidgetRef ref, LocationItem loc) {
    ref.read(weatherControllerProvider.notifier).setLocation(
          latitude: loc.latitude,
          longitude: loc.longitude,
          cityName: loc.name,
        );
    context.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedLocationsAsync = ref.watch(savedLocationsControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.skyNightTop,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Navigation Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIconButton(
                    icon: LucideIcons.arrowLeft,
                    tooltip: 'Back',
                    onPressed: () => context.pop(),
                  ),
                  const Text(
                    'Manage Locations',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  AppIconButton(
                    icon: LucideIcons.search,
                    tooltip: 'Search City',
                    onPressed: () {
                      CitySearchSheet.show(
                        context,
                        onLocationSelected: (loc) => _selectLocation(context, ref, loc),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24.0),

              // Use Current GPS Location Action Card
              AppGlassCard(
                borderRadius: 20.0,
                onTap: () async {
                  try {
                    final gpsLoc = await ref
                        .read(savedLocationsControllerProvider.notifier)
                        .getCurrentGpsLocation();
                    if (context.mounted) {
                      _selectLocation(context, ref, gpsLoc);
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text(e.toString()),
                        ),
                      );
                    }
                  }
                },
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
                child: const Row(
                  children: [
                    Icon(LucideIcons.locateFixed, color: Color(0xFF29B6F6), size: 22.0),
                    SizedBox(width: 14.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Use Current GPS Location',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Find weather for your exact sensor position',
                            style: TextStyle(fontSize: 12.0, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    Icon(LucideIcons.chevronRight, size: 18.0, color: Colors.white38),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),

              // Saved Cities Header
              const Text(
                'SAVED CITIES',
                style: AppTypography.cardHeader,
              ),
              const SizedBox(height: 12.0),

              // Reorderable Favorites List
              Expanded(
                child: savedLocationsAsync.when(
                  loading: () => ListView.separated(
                    itemCount: 3,
                    separatorBuilder: (_, __) => const SizedBox(height: 12.0),
                    itemBuilder: (_, __) => const AppGlassCard(
                      height: 72.0,
                      child: AppShimmerPlaceholder(width: double.infinity, height: 48.0),
                    ),
                  ),
                  error: (error, _) => AppErrorStateView(
                    message: error.toString(),
                    onRetry: () => ref.invalidate(savedLocationsControllerProvider),
                  ),
                  data: (locations) {
                    if (locations.isEmpty) {
                      return const Center(
                        child: Text(
                          'No saved cities yet. Tap the search icon to add a location.',
                          style: TextStyle(color: AppColors.textSecondary),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    return ReorderableListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: locations.length,
                      onReorderItem: (oldIndex, newIndex) {
                        ref
                            .read(savedLocationsControllerProvider.notifier)
                            .reorder(oldIndex, newIndex);
                      },
                      itemBuilder: (context, index) {
                        final loc = locations[index];
                        return ReorderableCityCard(
                          key: ValueKey('${loc.name}_${loc.latitude}_$index'),
                          location: loc,
                          index: index,
                          onTap: () => _selectLocation(context, ref, loc),
                          onDelete: () {
                            ref
                                .read(savedLocationsControllerProvider.notifier)
                                .removeLocation(loc);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
