// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyForecastImpl _$$DailyForecastImplFromJson(Map<String, dynamic> json) =>
    _$DailyForecastImpl(
      date: DateTime.parse(json['date'] as String),
      maxTemperature: (json['maxTemperature'] as num).toDouble(),
      minTemperature: (json['minTemperature'] as num).toDouble(),
      weatherCode: (json['weatherCode'] as num).toInt(),
      sunrise: DateTime.parse(json['sunrise'] as String),
      sunset: DateTime.parse(json['sunset'] as String),
      uvIndexMax: (json['uvIndexMax'] as num).toDouble(),
      precipitationSum: (json['precipitationSum'] as num).toDouble(),
      precipitationProbabilityMax: (json['precipitationProbabilityMax'] as num)
          .toInt(),
    );

Map<String, dynamic> _$$DailyForecastImplToJson(_$DailyForecastImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'maxTemperature': instance.maxTemperature,
      'minTemperature': instance.minTemperature,
      'weatherCode': instance.weatherCode,
      'sunrise': instance.sunrise.toIso8601String(),
      'sunset': instance.sunset.toIso8601String(),
      'uvIndexMax': instance.uvIndexMax,
      'precipitationSum': instance.precipitationSum,
      'precipitationProbabilityMax': instance.precipitationProbabilityMax,
    };
