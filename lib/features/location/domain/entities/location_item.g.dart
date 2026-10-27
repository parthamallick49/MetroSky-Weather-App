// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationItemImpl _$$LocationItemImplFromJson(Map<String, dynamic> json) =>
    _$LocationItemImpl(
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      country: json['country'] as String,
      admin1: json['admin1'] as String?,
      timezone: json['timezone'] as String?,
      isCurrentLocation: json['isCurrentLocation'] as bool? ?? false,
    );

Map<String, dynamic> _$$LocationItemImplToJson(_$LocationItemImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'country': instance.country,
      'admin1': instance.admin1,
      'timezone': instance.timezone,
      'isCurrentLocation': instance.isCurrentLocation,
    };
