import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_glass_card.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../core/widgets/app_shimmer_placeholder.dart';
import '../../../weather/presentation/controllers/weather_controller.dart';
import '../controllers/radar_controller.dart';
import 'radar_time_scrubber.dart';

/// Full interactive radar map displaying animated precipitation tiles over vector basemaps.
class RadarMapScreen extends ConsumerStatefulWidget {
  const RadarMapScreen({super.key});

  @override
  ConsumerState<RadarMapScreen> createState() => _RadarMapScreenState();
}

class _RadarMapScreenState extends ConsumerState<RadarMapScreen> {
  MapLibreMapController? _mapController;
  String? _currentRasterSourceId;

  void _onMapCreated(MapLibreMapController controller) {
    _mapController = controller;
  }

  void _onStyleLoaded() {
    _syncRadarLayer();
  }

  void _syncRadarLayer() {
    final controller = _mapController;
    if (controller == null) return;

    final radarState = ref.read(radarControllerProvider).valueOrNull;
    final tileUrl = radarState?.activeTileUrlTemplate;
    if (tileUrl == null) return;

    try {
      // In mobile environments with MapLibre, dynamic raster sources update
      // by swapping raster tile source URLs on frame transitions
      const sourceId = 'rainviewer_radar_source';
      const layerId = 'rainviewer_radar_layer';

      if (_currentRasterSourceId == null) {
        controller.addSource(
          sourceId,
          RasterSourceProperties(
            tiles: [tileUrl],
            tileSize: 256,
          ),
        );
        controller.addLayer(
          sourceId,
          layerId,
          const RasterLayerProperties(
            rasterOpacity: 0.75,
          ),
        );
        _currentRasterSourceId = sourceId;
      }
    } catch (_) {
      // Gracefully handle web or desktop platform view discrepancies
    }
  }

  @override
  Widget build(BuildContext context) {
    final radarAsync = ref.watch(radarControllerProvider);
    final activeLocation = ref.watch(activeWeatherLocationProvider);

    // Sync layer whenever radar frame changes
    ref.listen(radarControllerProvider, (prev, next) {
      if (prev?.valueOrNull?.activeFrameIndex != next.valueOrNull?.activeFrameIndex) {
        _syncRadarLayer();
      }
    });

    final initialCamera = CameraPosition(
      target: LatLng(activeLocation.latitude, activeLocation.longitude),
      zoom: 6.5,
    );

    return Scaffold(
      backgroundColor: AppColors.skyNightTop,
      body: Stack(
        children: [
          // 1. MapLibre GL Interactive Vector Basemap
          MapLibreMap(
            initialCameraPosition: initialCamera,
            styleString: ApiEndpoints.cartoDarkBasemapStyleUrl,
            onMapCreated: _onMapCreated,
            onStyleLoadedCallback: _onStyleLoaded,
            myLocationEnabled: false,
            compassEnabled: false,
            attributionButtonMargins: const Point(12, 120),
          ),

          // 2. Floating Header Navigation Bar
          SafeArea(
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
                  AppGlassCard(
                    borderRadius: 20.0,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    child: Row(
                      children: [
                        const Icon(LucideIcons.radar, size: 16.0, color: Color(0xFF29B6F6)),
                        const SizedBox(width: 8.0),
                        Text(
                          'Radar · ${activeLocation.cityName}',
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppIconButton(
                    icon: LucideIcons.refreshCw,
                    tooltip: 'Refresh Radar Scans',
                    onPressed: () => ref.refresh(radarControllerProvider),
                  ),
                ],
              ),
            ),
          ),

          // 3. Floating Bottom Radar Playback Time Scrubber
          Positioned(
            left: 20.0,
            right: 20.0,
            bottom: 36.0,
            child: radarAsync.when(
              loading: () => const AppGlassCard(
                height: 120.0,
                child: Center(
                  child: AppShimmerPlaceholder(width: double.infinity, height: 80.0),
                ),
              ),
              error: (err, _) => AppGlassCard(
                child: Text(
                  'Unable to load radar tiles: $err',
                  style: const TextStyle(color: Colors.white70, fontSize: 13.0),
                  textAlign: TextAlign.center,
                ),
              ),
              data: (state) => RadarTimeScrubber(
                state: state,
                onPlayToggle: () => ref.read(radarControllerProvider.notifier).togglePlay(),
                onStepForward: () => ref.read(radarControllerProvider.notifier).stepForward(),
                onStepBackward: () => ref.read(radarControllerProvider.notifier).stepBackward(),
                onScrub: (index) => ref.read(radarControllerProvider.notifier).setFrameIndex(index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
