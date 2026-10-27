import 'dart:ui';
import 'package:flutter/material.dart';

/// CustomPainter rendering a loaded Impeller [FragmentShader].
class WeatherShaderPainter extends CustomPainter {
  WeatherShaderPainter({
    required this.shader,
    required this.time,
    this.intensity = 1.0,
    this.wind = 0.0,
  });

  final FragmentShader shader;
  final double time;
  final double intensity;
  final double wind;

  @override
  void paint(Canvas canvas, Size size) {
    // Uniform index 0 & 1: u_resolution (vec2)
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);

    // Uniform index 2: u_time (float)
    shader.setFloat(2, time);

    // Uniform index 3: u_intensity (float)
    shader.setFloat(3, intensity);

    // Uniform index 4: u_wind (float)
    shader.setFloat(4, wind);

    final paint = Paint()..shader = shader;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant WeatherShaderPainter oldDelegate) {
    return oldDelegate.time != time ||
        oldDelegate.intensity != intensity ||
        oldDelegate.wind != wind ||
        oldDelegate.shader != shader;
  }
}
