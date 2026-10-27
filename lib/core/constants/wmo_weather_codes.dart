/// Weather condition categories derived from WMO codes.
enum WeatherConditionCategory {
  clear,
  partlyCloudy,
  overcast,
  fog,
  drizzle,
  rain,
  snow,
  thunderstorm,
  unknown,
}

/// Helper mapping WMO (World Meteorological Organization) weather interpretation codes
/// to human-readable descriptions, condition categories, and asset animation identifiers.
class WmoWeatherCode {
  WmoWeatherCode._();

  /// Returns the human-readable description for a given WMO weather code.
  static String getDescription(int code) {
    switch (code) {
      case 0:
        return 'Clear Sky';
      case 1:
        return 'Mainly Clear';
      case 2:
        return 'Partly Cloudy';
      case 3:
        return 'Overcast';
      case 45:
        return 'Fog';
      case 48:
        return 'Depositing Rime Fog';
      case 51:
        return 'Light Drizzle';
      case 53:
        return 'Moderate Drizzle';
      case 55:
        return 'Dense Drizzle';
      case 56:
        return 'Light Freezing Drizzle';
      case 57:
        return 'Dense Freezing Drizzle';
      case 61:
        return 'Slight Rain';
      case 62:
        return 'Moderate Rain';
      case 63:
        return 'Moderate Rain';
      case 65:
        return 'Heavy Rain';
      case 66:
        return 'Light Freezing Rain';
      case 67:
        return 'Heavy Freezing Rain';
      case 71:
        return 'Slight Snow Fall';
      case 73:
        return 'Moderate Snow Fall';
      case 75:
        return 'Heavy Snow Fall';
      case 77:
        return 'Snow Grains';
      case 80:
        return 'Slight Rain Showers';
      case 81:
        return 'Moderate Rain Showers';
      case 82:
        return 'Violent Rain Showers';
      case 85:
        return 'Slight Snow Showers';
      case 86:
        return 'Heavy Snow Showers';
      case 95:
        return 'Thunderstorm';
      case 96:
        return 'Thunderstorm with Slight Hail';
      case 99:
        return 'Thunderstorm with Heavy Hail';
      default:
        return 'Unknown';
    }
  }

  /// Maps a WMO code to a high-level [WeatherConditionCategory].
  static WeatherConditionCategory getCategory(int code) {
    if (code == 0) return WeatherConditionCategory.clear;
    if (code == 1 || code == 2) return WeatherConditionCategory.partlyCloudy;
    if (code == 3) return WeatherConditionCategory.overcast;
    if (code == 45 || code == 48) return WeatherConditionCategory.fog;
    if (code >= 51 && code <= 57) return WeatherConditionCategory.drizzle;
    if ((code >= 61 && code <= 67) || (code >= 80 && code <= 82)) {
      return WeatherConditionCategory.rain;
    }
    if ((code >= 71 && code <= 77) || (code >= 85 && code <= 86)) {
      return WeatherConditionCategory.snow;
    }
    if (code >= 95 && code <= 99) return WeatherConditionCategory.thunderstorm;
    return WeatherConditionCategory.unknown;
  }

  /// Returns the corresponding animation asset path based on code and day/night status.
  static String getAnimationAsset(int code, {required bool isDay}) {
    final category = getCategory(code);
    switch (category) {
      case WeatherConditionCategory.clear:
        return isDay ? 'assets/animations/clear_day.json' : 'assets/animations/clear_night.json';
      case WeatherConditionCategory.partlyCloudy:
        return isDay
            ? 'assets/animations/partly_cloudy_day.json'
            : 'assets/animations/partly_cloudy_night.json';
      case WeatherConditionCategory.overcast:
        return 'assets/animations/overcast.json';
      case WeatherConditionCategory.fog:
        return 'assets/animations/fog.json';
      case WeatherConditionCategory.drizzle:
      case WeatherConditionCategory.rain:
        return 'assets/animations/rain.json';
      case WeatherConditionCategory.snow:
        return 'assets/animations/snow.json';
      case WeatherConditionCategory.thunderstorm:
        return 'assets/animations/thunderstorm.json';
      case WeatherConditionCategory.unknown:
        return isDay ? 'assets/animations/clear_day.json' : 'assets/animations/clear_night.json';
    }
  }
}
