// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hourly_weather.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HourlyWeather _$HourlyWeatherFromJson(Map<String, dynamic> json) {
  return _HourlyWeather.fromJson(json);
}

/// @nodoc
mixin _$HourlyWeather {
  DateTime get time => throw _privateConstructorUsedError;
  double get temperature => throw _privateConstructorUsedError;
  int get relativeHumidity => throw _privateConstructorUsedError;
  double get dewPoint => throw _privateConstructorUsedError;
  int get precipitationProbability => throw _privateConstructorUsedError;
  double get precipitation => throw _privateConstructorUsedError;
  int get weatherCode => throw _privateConstructorUsedError;
  double get surfacePressure => throw _privateConstructorUsedError;
  double get visibility => throw _privateConstructorUsedError;
  double get windSpeed => throw _privateConstructorUsedError;
  double get uvIndex => throw _privateConstructorUsedError;
  bool get isDay => throw _privateConstructorUsedError;

  /// Serializes this HourlyWeather to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HourlyWeather
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HourlyWeatherCopyWith<HourlyWeather> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HourlyWeatherCopyWith<$Res> {
  factory $HourlyWeatherCopyWith(
    HourlyWeather value,
    $Res Function(HourlyWeather) then,
  ) = _$HourlyWeatherCopyWithImpl<$Res, HourlyWeather>;
  @useResult
  $Res call({
    DateTime time,
    double temperature,
    int relativeHumidity,
    double dewPoint,
    int precipitationProbability,
    double precipitation,
    int weatherCode,
    double surfacePressure,
    double visibility,
    double windSpeed,
    double uvIndex,
    bool isDay,
  });
}

/// @nodoc
class _$HourlyWeatherCopyWithImpl<$Res, $Val extends HourlyWeather>
    implements $HourlyWeatherCopyWith<$Res> {
  _$HourlyWeatherCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HourlyWeather
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? temperature = null,
    Object? relativeHumidity = null,
    Object? dewPoint = null,
    Object? precipitationProbability = null,
    Object? precipitation = null,
    Object? weatherCode = null,
    Object? surfacePressure = null,
    Object? visibility = null,
    Object? windSpeed = null,
    Object? uvIndex = null,
    Object? isDay = null,
  }) {
    return _then(
      _value.copyWith(
            time: null == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            temperature: null == temperature
                ? _value.temperature
                : temperature // ignore: cast_nullable_to_non_nullable
                      as double,
            relativeHumidity: null == relativeHumidity
                ? _value.relativeHumidity
                : relativeHumidity // ignore: cast_nullable_to_non_nullable
                      as int,
            dewPoint: null == dewPoint
                ? _value.dewPoint
                : dewPoint // ignore: cast_nullable_to_non_nullable
                      as double,
            precipitationProbability: null == precipitationProbability
                ? _value.precipitationProbability
                : precipitationProbability // ignore: cast_nullable_to_non_nullable
                      as int,
            precipitation: null == precipitation
                ? _value.precipitation
                : precipitation // ignore: cast_nullable_to_non_nullable
                      as double,
            weatherCode: null == weatherCode
                ? _value.weatherCode
                : weatherCode // ignore: cast_nullable_to_non_nullable
                      as int,
            surfacePressure: null == surfacePressure
                ? _value.surfacePressure
                : surfacePressure // ignore: cast_nullable_to_non_nullable
                      as double,
            visibility: null == visibility
                ? _value.visibility
                : visibility // ignore: cast_nullable_to_non_nullable
                      as double,
            windSpeed: null == windSpeed
                ? _value.windSpeed
                : windSpeed // ignore: cast_nullable_to_non_nullable
                      as double,
            uvIndex: null == uvIndex
                ? _value.uvIndex
                : uvIndex // ignore: cast_nullable_to_non_nullable
                      as double,
            isDay: null == isDay
                ? _value.isDay
                : isDay // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HourlyWeatherImplCopyWith<$Res>
    implements $HourlyWeatherCopyWith<$Res> {
  factory _$$HourlyWeatherImplCopyWith(
    _$HourlyWeatherImpl value,
    $Res Function(_$HourlyWeatherImpl) then,
  ) = __$$HourlyWeatherImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime time,
    double temperature,
    int relativeHumidity,
    double dewPoint,
    int precipitationProbability,
    double precipitation,
    int weatherCode,
    double surfacePressure,
    double visibility,
    double windSpeed,
    double uvIndex,
    bool isDay,
  });
}

/// @nodoc
class __$$HourlyWeatherImplCopyWithImpl<$Res>
    extends _$HourlyWeatherCopyWithImpl<$Res, _$HourlyWeatherImpl>
    implements _$$HourlyWeatherImplCopyWith<$Res> {
  __$$HourlyWeatherImplCopyWithImpl(
    _$HourlyWeatherImpl _value,
    $Res Function(_$HourlyWeatherImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HourlyWeather
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? temperature = null,
    Object? relativeHumidity = null,
    Object? dewPoint = null,
    Object? precipitationProbability = null,
    Object? precipitation = null,
    Object? weatherCode = null,
    Object? surfacePressure = null,
    Object? visibility = null,
    Object? windSpeed = null,
    Object? uvIndex = null,
    Object? isDay = null,
  }) {
    return _then(
      _$HourlyWeatherImpl(
        time: null == time
            ? _value.time
            : time // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        temperature: null == temperature
            ? _value.temperature
            : temperature // ignore: cast_nullable_to_non_nullable
                  as double,
        relativeHumidity: null == relativeHumidity
            ? _value.relativeHumidity
            : relativeHumidity // ignore: cast_nullable_to_non_nullable
                  as int,
        dewPoint: null == dewPoint
            ? _value.dewPoint
            : dewPoint // ignore: cast_nullable_to_non_nullable
                  as double,
        precipitationProbability: null == precipitationProbability
            ? _value.precipitationProbability
            : precipitationProbability // ignore: cast_nullable_to_non_nullable
                  as int,
        precipitation: null == precipitation
            ? _value.precipitation
            : precipitation // ignore: cast_nullable_to_non_nullable
                  as double,
        weatherCode: null == weatherCode
            ? _value.weatherCode
            : weatherCode // ignore: cast_nullable_to_non_nullable
                  as int,
        surfacePressure: null == surfacePressure
            ? _value.surfacePressure
            : surfacePressure // ignore: cast_nullable_to_non_nullable
                  as double,
        visibility: null == visibility
            ? _value.visibility
            : visibility // ignore: cast_nullable_to_non_nullable
                  as double,
        windSpeed: null == windSpeed
            ? _value.windSpeed
            : windSpeed // ignore: cast_nullable_to_non_nullable
                  as double,
        uvIndex: null == uvIndex
            ? _value.uvIndex
            : uvIndex // ignore: cast_nullable_to_non_nullable
                  as double,
        isDay: null == isDay
            ? _value.isDay
            : isDay // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HourlyWeatherImpl extends _HourlyWeather {
  const _$HourlyWeatherImpl({
    required this.time,
    required this.temperature,
    required this.relativeHumidity,
    required this.dewPoint,
    required this.precipitationProbability,
    required this.precipitation,
    required this.weatherCode,
    required this.surfacePressure,
    required this.visibility,
    required this.windSpeed,
    required this.uvIndex,
    required this.isDay,
  }) : super._();

  factory _$HourlyWeatherImpl.fromJson(Map<String, dynamic> json) =>
      _$$HourlyWeatherImplFromJson(json);

  @override
  final DateTime time;
  @override
  final double temperature;
  @override
  final int relativeHumidity;
  @override
  final double dewPoint;
  @override
  final int precipitationProbability;
  @override
  final double precipitation;
  @override
  final int weatherCode;
  @override
  final double surfacePressure;
  @override
  final double visibility;
  @override
  final double windSpeed;
  @override
  final double uvIndex;
  @override
  final bool isDay;

  @override
  String toString() {
    return 'HourlyWeather(time: $time, temperature: $temperature, relativeHumidity: $relativeHumidity, dewPoint: $dewPoint, precipitationProbability: $precipitationProbability, precipitation: $precipitation, weatherCode: $weatherCode, surfacePressure: $surfacePressure, visibility: $visibility, windSpeed: $windSpeed, uvIndex: $uvIndex, isDay: $isDay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HourlyWeatherImpl &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.relativeHumidity, relativeHumidity) ||
                other.relativeHumidity == relativeHumidity) &&
            (identical(other.dewPoint, dewPoint) ||
                other.dewPoint == dewPoint) &&
            (identical(
                  other.precipitationProbability,
                  precipitationProbability,
                ) ||
                other.precipitationProbability == precipitationProbability) &&
            (identical(other.precipitation, precipitation) ||
                other.precipitation == precipitation) &&
            (identical(other.weatherCode, weatherCode) ||
                other.weatherCode == weatherCode) &&
            (identical(other.surfacePressure, surfacePressure) ||
                other.surfacePressure == surfacePressure) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.windSpeed, windSpeed) ||
                other.windSpeed == windSpeed) &&
            (identical(other.uvIndex, uvIndex) || other.uvIndex == uvIndex) &&
            (identical(other.isDay, isDay) || other.isDay == isDay));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    time,
    temperature,
    relativeHumidity,
    dewPoint,
    precipitationProbability,
    precipitation,
    weatherCode,
    surfacePressure,
    visibility,
    windSpeed,
    uvIndex,
    isDay,
  );

  /// Create a copy of HourlyWeather
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HourlyWeatherImplCopyWith<_$HourlyWeatherImpl> get copyWith =>
      __$$HourlyWeatherImplCopyWithImpl<_$HourlyWeatherImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HourlyWeatherImplToJson(this);
  }
}

abstract class _HourlyWeather extends HourlyWeather {
  const factory _HourlyWeather({
    required final DateTime time,
    required final double temperature,
    required final int relativeHumidity,
    required final double dewPoint,
    required final int precipitationProbability,
    required final double precipitation,
    required final int weatherCode,
    required final double surfacePressure,
    required final double visibility,
    required final double windSpeed,
    required final double uvIndex,
    required final bool isDay,
  }) = _$HourlyWeatherImpl;
  const _HourlyWeather._() : super._();

  factory _HourlyWeather.fromJson(Map<String, dynamic> json) =
      _$HourlyWeatherImpl.fromJson;

  @override
  DateTime get time;
  @override
  double get temperature;
  @override
  int get relativeHumidity;
  @override
  double get dewPoint;
  @override
  int get precipitationProbability;
  @override
  double get precipitation;
  @override
  int get weatherCode;
  @override
  double get surfacePressure;
  @override
  double get visibility;
  @override
  double get windSpeed;
  @override
  double get uvIndex;
  @override
  bool get isDay;

  /// Create a copy of HourlyWeather
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HourlyWeatherImplCopyWith<_$HourlyWeatherImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
