// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HourlyWeatherImpl _$$HourlyWeatherImplFromJson(Map<String, dynamic> json) =>
    _$HourlyWeatherImpl(
      time: DateTime.parse(json['time'] as String),
      temperature: (json['temperature'] as num).toDouble(),
      relativeHumidity: (json['relativeHumidity'] as num).toInt(),
      dewPoint: (json['dewPoint'] as num).toDouble(),
      precipitationProbability: (json['precipitationProbability'] as num)
          .toInt(),
      precipitation: (json['precipitation'] as num).toDouble(),
      weatherCode: (json['weatherCode'] as num).toInt(),
      surfacePressure: (json['surfacePressure'] as num).toDouble(),
      visibility: (json['visibility'] as num).toDouble(),
      windSpeed: (json['windSpeed'] as num).toDouble(),
      uvIndex: (json['uvIndex'] as num).toDouble(),
      isDay: json['isDay'] as bool,
    );

Map<String, dynamic> _$$HourlyWeatherImplToJson(_$HourlyWeatherImpl instance) =>
    <String, dynamic>{
      'time': instance.time.toIso8601String(),
      'temperature': instance.temperature,
      'relativeHumidity': instance.relativeHumidity,
      'dewPoint': instance.dewPoint,
      'precipitationProbability': instance.precipitationProbability,
      'precipitation': instance.precipitation,
      'weatherCode': instance.weatherCode,
      'surfacePressure': instance.surfacePressure,
      'visibility': instance.visibility,
      'windSpeed': instance.windSpeed,
      'uvIndex': instance.uvIndex,
      'isDay': instance.isDay,
    };
