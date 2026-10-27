// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserPreferencesImpl _$$UserPreferencesImplFromJson(
  Map<String, dynamic> json,
) => _$UserPreferencesImpl(
  temperatureUnit:
      $enumDecodeNullable(_$TemperatureUnitEnumMap, json['temperatureUnit']) ??
      TemperatureUnit.celsius,
  windSpeedUnit:
      $enumDecodeNullable(_$WindSpeedUnitEnumMap, json['windSpeedUnit']) ??
      WindSpeedUnit.kmh,
  pressureUnit:
      $enumDecodeNullable(_$PressureUnitEnumMap, json['pressureUnit']) ??
      PressureUnit.hPa,
  precipitationUnit:
      $enumDecodeNullable(
        _$PrecipitationUnitEnumMap,
        json['precipitationUnit'],
      ) ??
      PrecipitationUnit.mm,
  enableShaders: json['enableShaders'] as bool? ?? true,
  enableParticles: json['enableParticles'] as bool? ?? true,
  enableHaptics: json['enableHaptics'] as bool? ?? true,
);

Map<String, dynamic> _$$UserPreferencesImplToJson(
  _$UserPreferencesImpl instance,
) => <String, dynamic>{
  'temperatureUnit': _$TemperatureUnitEnumMap[instance.temperatureUnit]!,
  'windSpeedUnit': _$WindSpeedUnitEnumMap[instance.windSpeedUnit]!,
  'pressureUnit': _$PressureUnitEnumMap[instance.pressureUnit]!,
  'precipitationUnit': _$PrecipitationUnitEnumMap[instance.precipitationUnit]!,
  'enableShaders': instance.enableShaders,
  'enableParticles': instance.enableParticles,
  'enableHaptics': instance.enableHaptics,
};

const _$TemperatureUnitEnumMap = {
  TemperatureUnit.celsius: 'celsius',
  TemperatureUnit.fahrenheit: 'fahrenheit',
};

const _$WindSpeedUnitEnumMap = {
  WindSpeedUnit.kmh: 'kmh',
  WindSpeedUnit.mph: 'mph',
  WindSpeedUnit.ms: 'ms',
};

const _$PressureUnitEnumMap = {
  PressureUnit.hPa: 'hPa',
  PressureUnit.inHg: 'inHg',
};

const _$PrecipitationUnitEnumMap = {
  PrecipitationUnit.mm: 'mm',
  PrecipitationUnit.inches: 'inches',
};
