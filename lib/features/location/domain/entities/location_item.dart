import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_item.freezed.dart';
part 'location_item.g.dart';

/// Immutable domain model representing a geographic location.
@freezed
class LocationItem with _$LocationItem {
  const LocationItem._();

  const factory LocationItem({
    required String name,
    required double latitude,
    required double longitude,
    required String country,
    String? admin1,
    String? timezone,
    @Default(false) bool isCurrentLocation,
  }) = _LocationItem;

  factory LocationItem.fromJson(Map<String, dynamic> json) =>
      _$LocationItemFromJson(json);

  /// Formatted subtitle (e.g. "California, United States" or "Japan").
  String get subtitle {
    if (admin1 != null && admin1!.isNotEmpty) {
      return '$admin1, $country';
    }
    return country;
  }
}
