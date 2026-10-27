import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/features/visual_engine/presentation/sky/dynamic_sky_gradient.dart';

void main() {
  group('DynamicSkyGradient', () {
    test('returns deep obsidian palette for night (elevation < -18°)', () {
      final palette = DynamicSkyGradient.calculatePalette(-25.0);

      expect(palette.top, AppColors.skyNightTop);
      expect(palette.bottom, AppColors.skyNightBottom);
    });

    test('interpolates between night and twilight for elevation between -18° and 0°', () {
      final palette = DynamicSkyGradient.calculatePalette(-9.0);

      // Should be halfway between night and twilight
      expect(palette.top, isNot(AppColors.skyNightTop));
      expect(palette.top, isNot(AppColors.skyDayTop));
    });

    test('returns daytime palette for high solar elevation (> 30°)', () {
      final palette = DynamicSkyGradient.calculatePalette(45.0);

      expect(palette.top, AppColors.skyDayTop);
      expect(palette.bottom, AppColors.skyDayBottom);
    });

    test('generates valid LinearGradient with top-to-bottom alignment', () {
      final gradient = DynamicSkyGradient.getGradient(15.0);

      expect(gradient.begin, Alignment.topCenter);
      expect(gradient.end, Alignment.bottomCenter);
      expect(gradient.colors.length, 2);
    });
  });
}
