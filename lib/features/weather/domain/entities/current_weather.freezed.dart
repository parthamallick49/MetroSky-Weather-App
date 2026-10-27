// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_weather.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CurrentWeather _$CurrentWeatherFromJson(Map<String, dynamic> json) {
  return _CurrentWeather.fromJson(json);
}

/// @nodoc
mixin _$CurrentWeather {
  double get temperature => throw _privateConstructorUsedError;
  double get apparentTemperature => throw _privateConstructorUsedError;
  int get relativeHumidity => throw _privateConstructorUsedError;
  double get surfacePressure => throw _privateConstructorUsedError;
  double get windSpeed => throw _privateConstructorUsedError;
  double get windDirection => throw _privateConstructorUsedError;
  double get precipitation => throw _privateConstructorUsedError;
  int get weatherCode => throw _privateConstructorUsedError;
  bool get isDay => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;

  /// Serializes this CurrentWeather to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CurrentWeather
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CurrentWeatherCopyWith<CurrentWeather> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentWeatherCopyWith<$Res> {
  factory $CurrentWeatherCopyWith(
    CurrentWeather value,
    $Res Function(CurrentWeather) then,
  ) = _$CurrentWeatherCopyWithImpl<$Res, CurrentWeather>;
  @useResult
  $Res call({
    double temperature,
    double apparentTemperature,
    int relativeHumidity,
    double surfacePressure,
    double windSpeed,
    double windDirection,
    double precipitation,
    int weatherCode,
    bool isDay,
    DateTime time,
  });
}

/// @nodoc
class _$CurrentWeatherCopyWithImpl<$Res, $Val extends CurrentWeather>
    implements $CurrentWeatherCopyWith<$Res> {
  _$CurrentWeatherCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CurrentWeather
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temperature = null,
    Object? apparentTemperature = null,
    Object? relativeHumidity = null,
    Object? surfacePressure = null,
    Object? windSpeed = null,
    Object? windDirection = null,
    Object? precipitation = null,
    Object? weatherCode = null,
    Object? isDay = null,
    Object? time = null,
  }) {
    return _then(
      _value.copyWith(
            temperature: null == temperature
                ? _value.temperature
                : temperature // ignore: cast_nullable_to_non_nullable
                      as double,
            apparentTemperature: null == apparentTemperature
                ? _value.apparentTemperature
                : apparentTemperature // ignore: cast_nullable_to_non_nullable
                      as double,
            relativeHumidity: null == relativeHumidity
                ? _value.relativeHumidity
                : relativeHumidity // ignore: cast_nullable_to_non_nullable
                      as int,
            surfacePressure: null == surfacePressure
                ? _value.surfacePressure
                : surfacePressure // ignore: cast_nullable_to_non_nullable
                      as double,
            windSpeed: null == windSpeed
                ? _value.windSpeed
                : windSpeed // ignore: cast_nullable_to_non_nullable
                      as double,
            windDirection: null == windDirection
                ? _value.windDirection
                : windDirection // ignore: cast_nullable_to_non_nullable
                      as double,
            precipitation: null == precipitation
                ? _value.precipitation
                : precipitation // ignore: cast_nullable_to_non_nullable
                      as double,
            weatherCode: null == weatherCode
                ? _value.weatherCode
                : weatherCode // ignore: cast_nullable_to_non_nullable
                      as int,
            isDay: null == isDay
                ? _value.isDay
                : isDay // ignore: cast_nullable_to_non_nullable
                      as bool,
            time: null == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CurrentWeatherImplCopyWith<$Res>
    implements $CurrentWeatherCopyWith<$Res> {
  factory _$$CurrentWeatherImplCopyWith(
    _$CurrentWeatherImpl value,
    $Res Function(_$CurrentWeatherImpl) then,
  ) = __$$CurrentWeatherImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double temperature,
    double apparentTemperature,
    int relativeHumidity,
    double surfacePressure,
    double windSpeed,
    double windDirection,
    double precipitation,
    int weatherCode,
    bool isDay,
    DateTime time,
  });
}

/// @nodoc
class __$$CurrentWeatherImplCopyWithImpl<$Res>
    extends _$CurrentWeatherCopyWithImpl<$Res, _$CurrentWeatherImpl>
    implements _$$CurrentWeatherImplCopyWith<$Res> {
  __$$CurrentWeatherImplCopyWithImpl(
    _$CurrentWeatherImpl _value,
    $Res Function(_$CurrentWeatherImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CurrentWeather
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temperature = null,
    Object? apparentTemperature = null,
    Object? relativeHumidity = null,
    Object? surfacePressure = null,
    Object? windSpeed = null,
    Object? windDirection = null,
    Object? precipitation = null,
    Object? weatherCode = null,
    Object? isDay = null,
    Object? time = null,
  }) {
    return _then(
      _$CurrentWeatherImpl(
        temperature: null == temperature
            ? _value.temperature
            : temperature // ignore: cast_nullable_to_non_nullable
                  as double,
        apparentTemperature: null == apparentTemperature
            ? _value.apparentTemperature
            : apparentTemperature // ignore: cast_nullable_to_non_nullable
                  as double,
        relativeHumidity: null == relativeHumidity
            ? _value.relativeHumidity
            : relativeHumidity // ignore: cast_nullable_to_non_nullable
                  as int,
        surfacePressure: null == surfacePressure
            ? _value.surfacePressure
            : surfacePressure // ignore: cast_nullable_to_non_nullable
                  as double,
        windSpeed: null == windSpeed
            ? _value.windSpeed
            : windSpeed // ignore: cast_nullable_to_non_nullable
                  as double,
        windDirection: null == windDirection
            ? _value.windDirection
            : windDirection // ignore: cast_nullable_to_non_nullable
                  as double,
        precipitation: null == precipitation
            ? _value.precipitation
            : precipitation // ignore: cast_nullable_to_non_nullable
                  as double,
        weatherCode: null == weatherCode
            ? _value.weatherCode
            : weatherCode // ignore: cast_nullable_to_non_nullable
                  as int,
        isDay: null == isDay
            ? _value.isDay
            : isDay // ignore: cast_nullable_to_non_nullable
                  as bool,
        time: null == time
            ? _value.time
            : time // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CurrentWeatherImpl extends _CurrentWeather {
  const _$CurrentWeatherImpl({
    required this.temperature,
    required this.apparentTemperature,
    required this.relativeHumidity,
    required this.surfacePressure,
    required this.windSpeed,
    required this.windDirection,
    required this.precipitation,
    required this.weatherCode,
    required this.isDay,
    required this.time,
  }) : super._();

  factory _$CurrentWeatherImpl.fromJson(Map<String, dynamic> json) =>
      _$$CurrentWeatherImplFromJson(json);

  @override
  final double temperature;
  @override
  final double apparentTemperature;
  @override
  final int relativeHumidity;
  @override
  final double surfacePressure;
  @override
  final double windSpeed;
  @override
  final double windDirection;
  @override
  final double precipitation;
  @override
  final int weatherCode;
  @override
  final bool isDay;
  @override
  final DateTime time;

  @override
  String toString() {
    return 'CurrentWeather(temperature: $temperature, apparentTemperature: $apparentTemperature, relativeHumidity: $relativeHumidity, surfacePressure: $surfacePressure, windSpeed: $windSpeed, windDirection: $windDirection, precipitation: $precipitation, weatherCode: $weatherCode, isDay: $isDay, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrentWeatherImpl &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.apparentTemperature, apparentTemperature) ||
                other.apparentTemperature == apparentTemperature) &&
            (identical(other.relativeHumidity, relativeHumidity) ||
                other.relativeHumidity == relativeHumidity) &&
            (identical(other.surfacePressure, surfacePressure) ||
                other.surfacePressure == surfacePressure) &&
            (identical(other.windSpeed, windSpeed) ||
                other.windSpeed == windSpeed) &&
            (identical(other.windDirection, windDirection) ||
                other.windDirection == windDirection) &&
            (identical(other.precipitation, precipitation) ||
                other.precipitation == precipitation) &&
            (identical(other.weatherCode, weatherCode) ||
                other.weatherCode == weatherCode) &&
            (identical(other.isDay, isDay) || other.isDay == isDay) &&
            (identical(other.time, time) || other.time == time));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    temperature,
    apparentTemperature,
    relativeHumidity,
    surfacePressure,
    windSpeed,
    windDirection,
    precipitation,
    weatherCode,
    isDay,
    time,
  );

  /// Create a copy of CurrentWeather
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrentWeatherImplCopyWith<_$CurrentWeatherImpl> get copyWith =>
      __$$CurrentWeatherImplCopyWithImpl<_$CurrentWeatherImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CurrentWeatherImplToJson(this);
  }
}

abstract class _CurrentWeather extends CurrentWeather {
  const factory _CurrentWeather({
    required final double temperature,
    required final double apparentTemperature,
    required final int relativeHumidity,
    required final double surfacePressure,
    required final double windSpeed,
    required final double windDirection,
    required final double precipitation,
    required final int weatherCode,
    required final bool isDay,
    required final DateTime time,
  }) = _$CurrentWeatherImpl;
  const _CurrentWeather._() : super._();

  factory _CurrentWeather.fromJson(Map<String, dynamic> json) =
      _$CurrentWeatherImpl.fromJson;

  @override
  double get temperature;
  @override
  double get apparentTemperature;
  @override
  int get relativeHumidity;
  @override
  double get surfacePressure;
  @override
  double get windSpeed;
  @override
  double get windDirection;
  @override
  double get precipitation;
  @override
  int get weatherCode;
  @override
  bool get isDay;
  @override
  DateTime get time;

  /// Create a copy of CurrentWeather
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CurrentWeatherImplCopyWith<_$CurrentWeatherImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
