// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CurrentWeatherImpl _$$CurrentWeatherImplFromJson(Map<String, dynamic> json) =>
    _$CurrentWeatherImpl(
      temperature: (json['temperature'] as num).toDouble(),
      apparentTemperature: (json['apparentTemperature'] as num).toDouble(),
      relativeHumidity: (json['relativeHumidity'] as num).toInt(),
      surfacePressure: (json['surfacePressure'] as num).toDouble(),
      windSpeed: (json['windSpeed'] as num).toDouble(),
      windDirection: (json['windDirection'] as num).toDouble(),
      precipitation: (json['precipitation'] as num).toDouble(),
      weatherCode: (json['weatherCode'] as num).toInt(),
      isDay: json['isDay'] as bool,
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$$CurrentWeatherImplToJson(
  _$CurrentWeatherImpl instance,
) => <String, dynamic>{
  'temperature': instance.temperature,
  'apparentTemperature': instance.apparentTemperature,
  'relativeHumidity': instance.relativeHumidity,
  'surfacePressure': instance.surfacePressure,
  'windSpeed': instance.windSpeed,
  'windDirection': instance.windDirection,
  'precipitation': instance.precipitation,
  'weatherCode': instance.weatherCode,
  'isDay': instance.isDay,
  'time': instance.time.toIso8601String(),
};
