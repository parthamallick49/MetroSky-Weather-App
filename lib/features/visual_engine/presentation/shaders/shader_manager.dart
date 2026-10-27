import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Service managing the asynchronous loading and memory caching of Impeller shaders.
class ShaderManager {
  ShaderManager._();

  static final ShaderManager instance = ShaderManager._();

  FragmentProgram? _rainProgram;
  FragmentProgram? _snowProgram;
  FragmentProgram? _skyProgram;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  /// Pre-warms and compiles shaders from assets.
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      final results = await Future.wait([
        FragmentProgram.fromAsset('assets/shaders/rain_particles.frag'),
        FragmentProgram.fromAsset('assets/shaders/snow_particles.frag'),
        FragmentProgram.fromAsset('assets/shaders/sky_gradient.frag'),
      ]);

      _rainProgram = results[0];
      _snowProgram = results[1];
      _skyProgram = results[2];
      _isInitialized = true;
    } catch (_) {
      // In headless test environments or devices without GPU shader support,
      // shaders gracefully fail to load, falling back to Canvas painters.
      _isInitialized = false;
    }
  }

  /// Creates a new [FragmentShader] instance for rain particles.
  FragmentShader? createRainShader() => _rainProgram?.fragmentShader();

  /// Creates a new [FragmentShader] instance for snow particles.
  FragmentShader? createSnowShader() => _snowProgram?.fragmentShader();

  /// Creates a new [FragmentShader] instance for sky gradient.
  FragmentShader? createSkyShader() => _skyProgram?.fragmentShader();
}

/// Global provider for [ShaderManager].
final shaderManagerProvider = Provider<ShaderManager>((ref) {
  return ShaderManager.instance;
});
