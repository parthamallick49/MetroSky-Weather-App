// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LocationItem _$LocationItemFromJson(Map<String, dynamic> json) {
  return _LocationItem.fromJson(json);
}

/// @nodoc
mixin _$LocationItem {
  String get name => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  String? get admin1 => throw _privateConstructorUsedError;
  String? get timezone => throw _privateConstructorUsedError;
  bool get isCurrentLocation => throw _privateConstructorUsedError;

  /// Serializes this LocationItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocationItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationItemCopyWith<LocationItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationItemCopyWith<$Res> {
  factory $LocationItemCopyWith(
    LocationItem value,
    $Res Function(LocationItem) then,
  ) = _$LocationItemCopyWithImpl<$Res, LocationItem>;
  @useResult
  $Res call({
    String name,
    double latitude,
    double longitude,
    String country,
    String? admin1,
    String? timezone,
    bool isCurrentLocation,
  });
}

/// @nodoc
class _$LocationItemCopyWithImpl<$Res, $Val extends LocationItem>
    implements $LocationItemCopyWith<$Res> {
  _$LocationItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? country = null,
    Object? admin1 = freezed,
    Object? timezone = freezed,
    Object? isCurrentLocation = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            country: null == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String,
            admin1: freezed == admin1
                ? _value.admin1
                : admin1 // ignore: cast_nullable_to_non_nullable
                      as String?,
            timezone: freezed == timezone
                ? _value.timezone
                : timezone // ignore: cast_nullable_to_non_nullable
                      as String?,
            isCurrentLocation: null == isCurrentLocation
                ? _value.isCurrentLocation
                : isCurrentLocation // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LocationItemImplCopyWith<$Res>
    implements $LocationItemCopyWith<$Res> {
  factory _$$LocationItemImplCopyWith(
    _$LocationItemImpl value,
    $Res Function(_$LocationItemImpl) then,
  ) = __$$LocationItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    double latitude,
    double longitude,
    String country,
    String? admin1,
    String? timezone,
    bool isCurrentLocation,
  });
}

/// @nodoc
class __$$LocationItemImplCopyWithImpl<$Res>
    extends _$LocationItemCopyWithImpl<$Res, _$LocationItemImpl>
    implements _$$LocationItemImplCopyWith<$Res> {
  __$$LocationItemImplCopyWithImpl(
    _$LocationItemImpl _value,
    $Res Function(_$LocationItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? country = null,
    Object? admin1 = freezed,
    Object? timezone = freezed,
    Object? isCurrentLocation = null,
  }) {
    return _then(
      _$LocationItemImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        country: null == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String,
        admin1: freezed == admin1
            ? _value.admin1
            : admin1 // ignore: cast_nullable_to_non_nullable
                  as String?,
        timezone: freezed == timezone
            ? _value.timezone
            : timezone // ignore: cast_nullable_to_non_nullable
                  as String?,
        isCurrentLocation: null == isCurrentLocation
            ? _value.isCurrentLocation
            : isCurrentLocation // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationItemImpl extends _LocationItem {
  const _$LocationItemImpl({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.country,
    this.admin1,
    this.timezone,
    this.isCurrentLocation = false,
  }) : super._();

  factory _$LocationItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationItemImplFromJson(json);

  @override
  final String name;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String country;
  @override
  final String? admin1;
  @override
  final String? timezone;
  @override
  @JsonKey()
  final bool isCurrentLocation;

  @override
  String toString() {
    return 'LocationItem(name: $name, latitude: $latitude, longitude: $longitude, country: $country, admin1: $admin1, timezone: $timezone, isCurrentLocation: $isCurrentLocation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationItemImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.admin1, admin1) || other.admin1 == admin1) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.isCurrentLocation, isCurrentLocation) ||
                other.isCurrentLocation == isCurrentLocation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    latitude,
    longitude,
    country,
    admin1,
    timezone,
    isCurrentLocation,
  );

  /// Create a copy of LocationItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationItemImplCopyWith<_$LocationItemImpl> get copyWith =>
      __$$LocationItemImplCopyWithImpl<_$LocationItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationItemImplToJson(this);
  }
}

abstract class _LocationItem extends LocationItem {
  const factory _LocationItem({
    required final String name,
    required final double latitude,
    required final double longitude,
    required final String country,
    final String? admin1,
    final String? timezone,
    final bool isCurrentLocation,
  }) = _$LocationItemImpl;
  const _LocationItem._() : super._();

  factory _LocationItem.fromJson(Map<String, dynamic> json) =
      _$LocationItemImpl.fromJson;

  @override
  String get name;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get country;
  @override
  String? get admin1;
  @override
  String? get timezone;
  @override
  bool get isCurrentLocation;

  /// Create a copy of LocationItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationItemImplCopyWith<_$LocationItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
