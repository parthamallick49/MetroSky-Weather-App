import 'dart:math' as math;

/// Immutable data holding calculated solar elevation and azimuth angles.
class SolarPosition {
  const SolarPosition({
    required this.elevationDegrees,
    required this.azimuthDegrees,
  });

  /// Elevation in degrees above the horizon (-90° to +90°).
  /// Greater than 0° = Above horizon (Daylight)
  /// -6° to 0° = Civil Twilight
  /// -12° to -6° = Nautical Twilight
  /// -18° to -12° = Astronomical Twilight
  /// Below -18° = Night
  final double elevationDegrees;

  /// Compass azimuth in degrees from North (0° = North, 90° = East, 180° = South, 270° = West).
  final double azimuthDegrees;

  /// Whether the sun is currently above the horizon.
  bool get isDay => elevationDegrees > 0;

  /// Whether currently in twilight (-18° <= elevation <= 0°).
  bool get isTwilight => elevationDegrees >= -18 && elevationDegrees <= 0;

  /// Whether currently in golden hour (0° <= elevation <= 6°).
  bool get isGoldenHour => elevationDegrees >= 0 && elevationDegrees <= 6;
}

/// Pure astronomical mathematical calculator estimating solar position.
class SolarCalculator {
  SolarCalculator._();

  static const double _degToRad = math.pi / 180.0;
  static const double _radToDeg = 180.0 / math.pi;

  /// Calculates the estimated [SolarPosition] for a given geographic coordinate and UTC time.
  static SolarPosition calculate({
    required double latitude,
    required double longitude,
    required DateTime utcDateTime,
  }) {
    // Day of the year
    final startOfYear = DateTime.utc(utcDateTime.year, 1, 1);
    final dayOfYear = utcDateTime.difference(startOfYear).inDays + 1;

    // Fractional hour of the day in UTC
    final hourOfDay = utcDateTime.hour +
        (utcDateTime.minute / 60.0) +
        (utcDateTime.second / 3600.0);

    // Fractional year in radians
    final gamma = (2 * math.pi / 365.0) * (dayOfYear - 1 + (hourOfDay - 12) / 24.0);

    // Equation of time in minutes
    final eqtime = 229.18 *
        (0.000075 +
            0.001868 * math.cos(gamma) -
            0.032077 * math.sin(gamma) -
            0.014615 * math.cos(2 * gamma) -
            0.040849 * math.sin(2 * gamma));

    // Solar declination in radians
    final decl = 0.006918 -
        0.399912 * math.cos(gamma) +
        0.070257 * math.sin(gamma) -
        0.006758 * math.cos(2 * gamma) +
        0.000907 * math.sin(2 * gamma) -
        0.002697 * math.cos(3 * gamma) +
        0.00148 * math.sin(3 * gamma);

    // Time offset in minutes
    final timeOffset = eqtime + 4 * longitude;

    // True solar time in minutes
    final trueSolarTime = (hourOfDay * 60.0) + timeOffset;
    final solarHour = (trueSolarTime / 4.0) - 180.0; // Hour angle in degrees
    final haRad = solarHour * _degToRad;

    final latRad = latitude * _degToRad;

    // Solar zenith angle in radians
    final cosZenith = (math.sin(latRad) * math.sin(decl)) +
        (math.cos(latRad) * math.cos(decl) * math.cos(haRad));
    final clampedCosZenith = cosZenith.clamp(-1.0, 1.0);
    final zenithRad = math.acos(clampedCosZenith);

    // Solar elevation angle in degrees
    final elevation = 90.0 - (zenithRad * _radToDeg);

    // Solar azimuth angle in radians
    final cosAzimuth = (math.sin(decl) - (math.sin(latRad) * math.cos(zenithRad))) /
        (math.cos(latRad) * math.sin(zenithRad));
    final clampedCosAzimuth = cosAzimuth.clamp(-1.0, 1.0);
    var azimuthRad = math.acos(clampedCosAzimuth);
    if (haRad > 0) {
      azimuthRad = (2 * math.pi) - azimuthRad;
    }
    final azimuth = azimuthRad * _radToDeg;

    return SolarPosition(
      elevationDegrees: elevation,
      azimuthDegrees: azimuth,
    );
  }
}
