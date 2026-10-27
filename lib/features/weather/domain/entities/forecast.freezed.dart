// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forecast.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Forecast _$ForecastFromJson(Map<String, dynamic> json) {
  return _Forecast.fromJson(json);
}

/// @nodoc
mixin _$Forecast {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get timezone => throw _privateConstructorUsedError;
  CurrentWeather get current => throw _privateConstructorUsedError;
  List<HourlyWeather> get hourly => throw _privateConstructorUsedError;
  List<DailyForecast> get daily => throw _privateConstructorUsedError;
  AirQuality get airQuality => throw _privateConstructorUsedError;
  DateTime get fetchedAt => throw _privateConstructorUsedError;

  /// Serializes this Forecast to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Forecast
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForecastCopyWith<Forecast> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForecastCopyWith<$Res> {
  factory $ForecastCopyWith(Forecast value, $Res Function(Forecast) then) =
      _$ForecastCopyWithImpl<$Res, Forecast>;
  @useResult
  $Res call({
    double latitude,
    double longitude,
    String timezone,
    CurrentWeather current,
    List<HourlyWeather> hourly,
    List<DailyForecast> daily,
    AirQuality airQuality,
    DateTime fetchedAt,
  });

  $CurrentWeatherCopyWith<$Res> get current;
  $AirQualityCopyWith<$Res> get airQuality;
}

/// @nodoc
class _$ForecastCopyWithImpl<$Res, $Val extends Forecast>
    implements $ForecastCopyWith<$Res> {
  _$ForecastCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Forecast
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? timezone = null,
    Object? current = null,
    Object? hourly = null,
    Object? daily = null,
    Object? airQuality = null,
    Object? fetchedAt = null,
  }) {
    return _then(
      _value.copyWith(
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            timezone: null == timezone
                ? _value.timezone
                : timezone // ignore: cast_nullable_to_non_nullable
                      as String,
            current: null == current
                ? _value.current
                : current // ignore: cast_nullable_to_non_nullable
                      as CurrentWeather,
            hourly: null == hourly
                ? _value.hourly
                : hourly // ignore: cast_nullable_to_non_nullable
                      as List<HourlyWeather>,
            daily: null == daily
                ? _value.daily
                : daily // ignore: cast_nullable_to_non_nullable
                      as List<DailyForecast>,
            airQuality: null == airQuality
                ? _value.airQuality
                : airQuality // ignore: cast_nullable_to_non_nullable
                      as AirQuality,
            fetchedAt: null == fetchedAt
                ? _value.fetchedAt
                : fetchedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of Forecast
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CurrentWeatherCopyWith<$Res> get current {
    return $CurrentWeatherCopyWith<$Res>(_value.current, (value) {
      return _then(_value.copyWith(current: value) as $Val);
    });
  }

  /// Create a copy of Forecast
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AirQualityCopyWith<$Res> get airQuality {
    return $AirQualityCopyWith<$Res>(_value.airQuality, (value) {
      return _then(_value.copyWith(airQuality: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ForecastImplCopyWith<$Res>
    implements $ForecastCopyWith<$Res> {
  factory _$$ForecastImplCopyWith(
    _$ForecastImpl value,
    $Res Function(_$ForecastImpl) then,
  ) = __$$ForecastImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double latitude,
    double longitude,
    String timezone,
    CurrentWeather current,
    List<HourlyWeather> hourly,
    List<DailyForecast> daily,
    AirQuality airQuality,
    DateTime fetchedAt,
  });

  @override
  $CurrentWeatherCopyWith<$Res> get current;
  @override
  $AirQualityCopyWith<$Res> get airQuality;
}

/// @nodoc
class __$$ForecastImplCopyWithImpl<$Res>
    extends _$ForecastCopyWithImpl<$Res, _$ForecastImpl>
    implements _$$ForecastImplCopyWith<$Res> {
  __$$ForecastImplCopyWithImpl(
    _$ForecastImpl _value,
    $Res Function(_$ForecastImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Forecast
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? timezone = null,
    Object? current = null,
    Object? hourly = null,
    Object? daily = null,
    Object? airQuality = null,
    Object? fetchedAt = null,
  }) {
    return _then(
      _$ForecastImpl(
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        timezone: null == timezone
            ? _value.timezone
            : timezone // ignore: cast_nullable_to_non_nullable
                  as String,
        current: null == current
            ? _value.current
            : current // ignore: cast_nullable_to_non_nullable
                  as CurrentWeather,
        hourly: null == hourly
            ? _value._hourly
            : hourly // ignore: cast_nullable_to_non_nullable
                  as List<HourlyWeather>,
        daily: null == daily
            ? _value._daily
            : daily // ignore: cast_nullable_to_non_nullable
                  as List<DailyForecast>,
        airQuality: null == airQuality
            ? _value.airQuality
            : airQuality // ignore: cast_nullable_to_non_nullable
                  as AirQuality,
        fetchedAt: null == fetchedAt
            ? _value.fetchedAt
            : fetchedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ForecastImpl implements _Forecast {
  const _$ForecastImpl({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.current,
    required final List<HourlyWeather> hourly,
    required final List<DailyForecast> daily,
    required this.airQuality,
    required this.fetchedAt,
  }) : _hourly = hourly,
       _daily = daily;

  factory _$ForecastImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForecastImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String timezone;
  @override
  final CurrentWeather current;
  final List<HourlyWeather> _hourly;
  @override
  List<HourlyWeather> get hourly {
    if (_hourly is EqualUnmodifiableListView) return _hourly;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hourly);
  }

  final List<DailyForecast> _daily;
  @override
  List<DailyForecast> get daily {
    if (_daily is EqualUnmodifiableListView) return _daily;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_daily);
  }

  @override
  final AirQuality airQuality;
  @override
  final DateTime fetchedAt;

  @override
  String toString() {
    return 'Forecast(latitude: $latitude, longitude: $longitude, timezone: $timezone, current: $current, hourly: $hourly, daily: $daily, airQuality: $airQuality, fetchedAt: $fetchedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForecastImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.current, current) || other.current == current) &&
            const DeepCollectionEquality().equals(other._hourly, _hourly) &&
            const DeepCollectionEquality().equals(other._daily, _daily) &&
            (identical(other.airQuality, airQuality) ||
                other.airQuality == airQuality) &&
            (identical(other.fetchedAt, fetchedAt) ||
                other.fetchedAt == fetchedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    latitude,
    longitude,
    timezone,
    current,
    const DeepCollectionEquality().hash(_hourly),
    const DeepCollectionEquality().hash(_daily),
    airQuality,
    fetchedAt,
  );

  /// Create a copy of Forecast
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForecastImplCopyWith<_$ForecastImpl> get copyWith =>
      __$$ForecastImplCopyWithImpl<_$ForecastImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForecastImplToJson(this);
  }
}

abstract class _Forecast implements Forecast {
  const factory _Forecast({
    required final double latitude,
    required final double longitude,
    required final String timezone,
    required final CurrentWeather current,
    required final List<HourlyWeather> hourly,
    required final List<DailyForecast> daily,
    required final AirQuality airQuality,
    required final DateTime fetchedAt,
  }) = _$ForecastImpl;

  factory _Forecast.fromJson(Map<String, dynamic> json) =
      _$ForecastImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get timezone;
  @override
  CurrentWeather get current;
  @override
  List<HourlyWeather> get hourly;
  @override
  List<DailyForecast> get daily;
  @override
  AirQuality get airQuality;
  @override
  DateTime get fetchedAt;

  /// Create a copy of Forecast
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForecastImplCopyWith<_$ForecastImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
