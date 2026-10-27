import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/wmo_weather_codes.dart';
import '../../../../core/utils/solar_calculator.dart';
import 'shaders/shader_manager.dart';
import 'shaders/weather_shader_painter.dart';
import 'sky/dynamic_sky_gradient.dart';

/// Full-screen ambient atmospheric scaffold layering celestial sky and GPU fragment shaders.
class WeatherSceneScaffold extends ConsumerStatefulWidget {
  const WeatherSceneScaffold({
    super.key,
    required this.child,
    this.conditionCategory = WeatherConditionCategory.clear,
    this.solarElevation = 15.0,
    this.windSpeedKmh = 10.0,
    this.particleIntensity = 1.0,
  });

  final Widget child;
  final WeatherConditionCategory conditionCategory;
  final double solarElevation;
  final double windSpeedKmh;
  final double particleIntensity;

  @override
  ConsumerState<WeatherSceneScaffold> createState() => _WeatherSceneScaffoldState();
}

class _WeatherSceneScaffoldState extends ConsumerState<WeatherSceneScaffold>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late final AnimationController _ticker;
  FragmentShader? _currentShader;
  WeatherConditionCategory? _cachedCategory;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _ticker = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1000),
    )..repeat();

    _updateShader();
  }

  @override
  void didUpdateWidget(covariant WeatherSceneScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.conditionCategory != widget.conditionCategory) {
      _updateShader();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      _ticker.stop();
    } else if (state == AppLifecycleState.resumed) {
      _ticker.repeat();
    }
  }

  void _updateShader() {
    if (_cachedCategory == widget.conditionCategory && _currentShader != null) {
      return;
    }
    _cachedCategory = widget.conditionCategory;

    final manager = ShaderManager.instance;
    if (widget.conditionCategory == WeatherConditionCategory.rain ||
        widget.conditionCategory == WeatherConditionCategory.drizzle ||
        widget.conditionCategory == WeatherConditionCategory.thunderstorm) {
      _currentShader = manager.createRainShader();
    } else if (widget.conditionCategory == WeatherConditionCategory.snow) {
      _currentShader = manager.createSnowShader();
    } else {
      _currentShader = null;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate normalized wind factor (-1.0 to 1.0)
    final windFactor = (widget.windSpeedKmh / 50.0).clamp(-1.0, 1.0);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Dynamic Celestial Sky Gradient Layer
          DynamicSkyBackground(
            solarPosition: SolarPosition(
              elevationDegrees: widget.solarElevation,
              azimuthDegrees: 180.0,
            ),
          ),

          // 2. Ambient GPU Particle Shader Layer (Impeller)
          if (_currentShader != null)
            AnimatedBuilder(
              animation: _ticker,
              builder: (context, _) {
                // Time uniform in seconds
                final time = _ticker.lastElapsedDuration?.inMilliseconds ?? 0;
                final timeSeconds = time / 1000.0;

                return CustomPaint(
                  painter: WeatherShaderPainter(
                    shader: _currentShader!,
                    time: timeSeconds,
                    intensity: widget.particleIntensity,
                    wind: windFactor,
                  ),
                );
              },
            ),

          // 3. Foreground Application Content
          widget.child,
        ],
      ),
    );
  }
}
