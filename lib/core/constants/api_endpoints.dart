/// Centralized API endpoint URLs and query parameter constants.
class ApiEndpoints {
  ApiEndpoints._();

  /// Open-Meteo Forecast Base URL
  static const String openMeteoForecastBaseUrl = 'https://api.open-meteo.com/v1';

  /// Open-Meteo Air Quality Base URL
  static const String openMeteoAirQualityBaseUrl = 'https://air-quality-api.open-meteo.com/v1';

  /// Open-Meteo Geocoding Base URL
  static const String openMeteoGeocodingBaseUrl = 'https://geocoding-api.open-meteo.com/v1';

  /// RainViewer Weather Maps Base URL (for radar raster frames)
  static const String rainViewerBaseUrl = 'https://api.rainviewer.com/public';

  /// RainViewer Radar Tile Cache template URL
  /// Template format: {host}{path}/{size}/{z}/{x}/{y}/{color}/{options}.png
  static const String rainViewerTileTemplate = 'https://tilecache.rainviewer.com';

  /// MapLibre Vector Basemap Style URL (Carto Positron Dark/Light)
  static const String cartoDarkBasemapStyleUrl = 
      'https://basemaps.cartocdn.com/gl/dark-matter-gl-style/style.json';
  static const String cartoPositronBasemapStyleUrl = 
      'https://basemaps.cartocdn.com/gl/positron-gl-style/style.json';
}
