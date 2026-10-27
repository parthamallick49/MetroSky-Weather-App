/// Pure utility for converting and formatting temperature metrics.
class TemperatureFormatter {
  TemperatureFormatter._();

  /// Converts Celsius to Fahrenheit.
  static double toFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  /// Converts Fahrenheit to Celsius.
  static double toCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  /// Formats temperature into a rounded string with degree symbol.
  /// Example: 21.4 -> "21°" or "71°F"
  static String format(
    double celsius, {
    bool isFahrenheit = false,
    bool showUnit = false,
  }) {
    final value = isFahrenheit ? toFahrenheit(celsius) : celsius;
    final rounded = value.round();
    if (showUnit) {
      return '$rounded°${isFahrenheit ? "F" : "C"}';
    }
    return '$rounded°';
  }

  /// Formats temperature high/low range string.
  /// Example: "H: 24°  L: 16°"
  static String formatRange(
    double maxCelsius,
    double minCelsius, {
    bool isFahrenheit = false,
  }) {
    final maxStr = format(maxCelsius, isFahrenheit: isFahrenheit);
    final minStr = format(minCelsius, isFahrenheit: isFahrenheit);
    return 'H: $maxStr  L: $minStr';
  }
}
