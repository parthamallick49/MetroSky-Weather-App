// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'air_quality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AirQualityImpl _$$AirQualityImplFromJson(Map<String, dynamic> json) =>
    _$AirQualityImpl(
      europeanAqi: (json['europeanAqi'] as num).toInt(),
      usAqi: (json['usAqi'] as num).toInt(),
      pm10: (json['pm10'] as num).toDouble(),
      pm25: (json['pm25'] as num).toDouble(),
      carbonMonoxide: (json['carbonMonoxide'] as num).toDouble(),
      nitrogenDioxide: (json['nitrogenDioxide'] as num).toDouble(),
      sulphurDioxide: (json['sulphurDioxide'] as num).toDouble(),
      ozone: (json['ozone'] as num).toDouble(),
    );

Map<String, dynamic> _$$AirQualityImplToJson(_$AirQualityImpl instance) =>
    <String, dynamic>{
      'europeanAqi': instance.europeanAqi,
      'usAqi': instance.usAqi,
      'pm10': instance.pm10,
      'pm25': instance.pm25,
      'carbonMonoxide': instance.carbonMonoxide,
      'nitrogenDioxide': instance.nitrogenDioxide,
      'sulphurDioxide': instance.sulphurDioxide,
      'ozone': instance.ozone,
    };
