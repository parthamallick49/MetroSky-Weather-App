// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'radar_frame.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RadarFrame _$RadarFrameFromJson(Map<String, dynamic> json) {
  return _RadarFrame.fromJson(json);
}

/// @nodoc
mixin _$RadarFrame {
  int get timestamp => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  bool get isNowcast => throw _privateConstructorUsedError;

  /// Serializes this RadarFrame to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RadarFrame
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RadarFrameCopyWith<RadarFrame> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RadarFrameCopyWith<$Res> {
  factory $RadarFrameCopyWith(
    RadarFrame value,
    $Res Function(RadarFrame) then,
  ) = _$RadarFrameCopyWithImpl<$Res, RadarFrame>;
  @useResult
  $Res call({int timestamp, String path, bool isNowcast});
}

/// @nodoc
class _$RadarFrameCopyWithImpl<$Res, $Val extends RadarFrame>
    implements $RadarFrameCopyWith<$Res> {
  _$RadarFrameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RadarFrame
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? path = null,
    Object? isNowcast = null,
  }) {
    return _then(
      _value.copyWith(
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as int,
            path: null == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                      as String,
            isNowcast: null == isNowcast
                ? _value.isNowcast
                : isNowcast // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RadarFrameImplCopyWith<$Res>
    implements $RadarFrameCopyWith<$Res> {
  factory _$$RadarFrameImplCopyWith(
    _$RadarFrameImpl value,
    $Res Function(_$RadarFrameImpl) then,
  ) = __$$RadarFrameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int timestamp, String path, bool isNowcast});
}

/// @nodoc
class __$$RadarFrameImplCopyWithImpl<$Res>
    extends _$RadarFrameCopyWithImpl<$Res, _$RadarFrameImpl>
    implements _$$RadarFrameImplCopyWith<$Res> {
  __$$RadarFrameImplCopyWithImpl(
    _$RadarFrameImpl _value,
    $Res Function(_$RadarFrameImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RadarFrame
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? path = null,
    Object? isNowcast = null,
  }) {
    return _then(
      _$RadarFrameImpl(
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as int,
        path: null == path
            ? _value.path
            : path // ignore: cast_nullable_to_non_nullable
                  as String,
        isNowcast: null == isNowcast
            ? _value.isNowcast
            : isNowcast // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RadarFrameImpl extends _RadarFrame {
  const _$RadarFrameImpl({
    required this.timestamp,
    required this.path,
    required this.isNowcast,
  }) : super._();

  factory _$RadarFrameImpl.fromJson(Map<String, dynamic> json) =>
      _$$RadarFrameImplFromJson(json);

  @override
  final int timestamp;
  @override
  final String path;
  @override
  final bool isNowcast;

  @override
  String toString() {
    return 'RadarFrame(timestamp: $timestamp, path: $path, isNowcast: $isNowcast)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RadarFrameImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.isNowcast, isNowcast) ||
                other.isNowcast == isNowcast));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, timestamp, path, isNowcast);

  /// Create a copy of RadarFrame
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RadarFrameImplCopyWith<_$RadarFrameImpl> get copyWith =>
      __$$RadarFrameImplCopyWithImpl<_$RadarFrameImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RadarFrameImplToJson(this);
  }
}

abstract class _RadarFrame extends RadarFrame {
  const factory _RadarFrame({
    required final int timestamp,
    required final String path,
    required final bool isNowcast,
  }) = _$RadarFrameImpl;
  const _RadarFrame._() : super._();

  factory _RadarFrame.fromJson(Map<String, dynamic> json) =
      _$RadarFrameImpl.fromJson;

  @override
  int get timestamp;
  @override
  String get path;
  @override
  bool get isNowcast;

  /// Create a copy of RadarFrame
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RadarFrameImplCopyWith<_$RadarFrameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RadarTimeline _$RadarTimelineFromJson(Map<String, dynamic> json) {
  return _RadarTimeline.fromJson(json);
}

/// @nodoc
mixin _$RadarTimeline {
  String get host => throw _privateConstructorUsedError;
  List<RadarFrame> get pastFrames => throw _privateConstructorUsedError;
  List<RadarFrame> get nowcastFrames => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;

  /// Serializes this RadarTimeline to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RadarTimeline
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RadarTimelineCopyWith<RadarTimeline> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RadarTimelineCopyWith<$Res> {
  factory $RadarTimelineCopyWith(
    RadarTimeline value,
    $Res Function(RadarTimeline) then,
  ) = _$RadarTimelineCopyWithImpl<$Res, RadarTimeline>;
  @useResult
  $Res call({
    String host,
    List<RadarFrame> pastFrames,
    List<RadarFrame> nowcastFrames,
    DateTime generatedAt,
  });
}

/// @nodoc
class _$RadarTimelineCopyWithImpl<$Res, $Val extends RadarTimeline>
    implements $RadarTimelineCopyWith<$Res> {
  _$RadarTimelineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RadarTimeline
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? host = null,
    Object? pastFrames = null,
    Object? nowcastFrames = null,
    Object? generatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            host: null == host
                ? _value.host
                : host // ignore: cast_nullable_to_non_nullable
                      as String,
            pastFrames: null == pastFrames
                ? _value.pastFrames
                : pastFrames // ignore: cast_nullable_to_non_nullable
                      as List<RadarFrame>,
            nowcastFrames: null == nowcastFrames
                ? _value.nowcastFrames
                : nowcastFrames // ignore: cast_nullable_to_non_nullable
                      as List<RadarFrame>,
            generatedAt: null == generatedAt
                ? _value.generatedAt
                : generatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RadarTimelineImplCopyWith<$Res>
    implements $RadarTimelineCopyWith<$Res> {
  factory _$$RadarTimelineImplCopyWith(
    _$RadarTimelineImpl value,
    $Res Function(_$RadarTimelineImpl) then,
  ) = __$$RadarTimelineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String host,
    List<RadarFrame> pastFrames,
    List<RadarFrame> nowcastFrames,
    DateTime generatedAt,
  });
}

/// @nodoc
class __$$RadarTimelineImplCopyWithImpl<$Res>
    extends _$RadarTimelineCopyWithImpl<$Res, _$RadarTimelineImpl>
    implements _$$RadarTimelineImplCopyWith<$Res> {
  __$$RadarTimelineImplCopyWithImpl(
    _$RadarTimelineImpl _value,
    $Res Function(_$RadarTimelineImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RadarTimeline
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? host = null,
    Object? pastFrames = null,
    Object? nowcastFrames = null,
    Object? generatedAt = null,
  }) {
    return _then(
      _$RadarTimelineImpl(
        host: null == host
            ? _value.host
            : host // ignore: cast_nullable_to_non_nullable
                  as String,
        pastFrames: null == pastFrames
            ? _value._pastFrames
            : pastFrames // ignore: cast_nullable_to_non_nullable
                  as List<RadarFrame>,
        nowcastFrames: null == nowcastFrames
            ? _value._nowcastFrames
            : nowcastFrames // ignore: cast_nullable_to_non_nullable
                  as List<RadarFrame>,
        generatedAt: null == generatedAt
            ? _value.generatedAt
            : generatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RadarTimelineImpl extends _RadarTimeline {
  const _$RadarTimelineImpl({
    required this.host,
    required final List<RadarFrame> pastFrames,
    required final List<RadarFrame> nowcastFrames,
    required this.generatedAt,
  }) : _pastFrames = pastFrames,
       _nowcastFrames = nowcastFrames,
       super._();

  factory _$RadarTimelineImpl.fromJson(Map<String, dynamic> json) =>
      _$$RadarTimelineImplFromJson(json);

  @override
  final String host;
  final List<RadarFrame> _pastFrames;
  @override
  List<RadarFrame> get pastFrames {
    if (_pastFrames is EqualUnmodifiableListView) return _pastFrames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pastFrames);
  }

  final List<RadarFrame> _nowcastFrames;
  @override
  List<RadarFrame> get nowcastFrames {
    if (_nowcastFrames is EqualUnmodifiableListView) return _nowcastFrames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nowcastFrames);
  }

  @override
  final DateTime generatedAt;

  @override
  String toString() {
    return 'RadarTimeline(host: $host, pastFrames: $pastFrames, nowcastFrames: $nowcastFrames, generatedAt: $generatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RadarTimelineImpl &&
            (identical(other.host, host) || other.host == host) &&
            const DeepCollectionEquality().equals(
              other._pastFrames,
              _pastFrames,
            ) &&
            const DeepCollectionEquality().equals(
              other._nowcastFrames,
              _nowcastFrames,
            ) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    host,
    const DeepCollectionEquality().hash(_pastFrames),
    const DeepCollectionEquality().hash(_nowcastFrames),
    generatedAt,
  );

  /// Create a copy of RadarTimeline
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RadarTimelineImplCopyWith<_$RadarTimelineImpl> get copyWith =>
      __$$RadarTimelineImplCopyWithImpl<_$RadarTimelineImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RadarTimelineImplToJson(this);
  }
}

abstract class _RadarTimeline extends RadarTimeline {
  const factory _RadarTimeline({
    required final String host,
    required final List<RadarFrame> pastFrames,
    required final List<RadarFrame> nowcastFrames,
    required final DateTime generatedAt,
  }) = _$RadarTimelineImpl;
  const _RadarTimeline._() : super._();

  factory _RadarTimeline.fromJson(Map<String, dynamic> json) =
      _$RadarTimelineImpl.fromJson;

  @override
  String get host;
  @override
  List<RadarFrame> get pastFrames;
  @override
  List<RadarFrame> get nowcastFrames;
  @override
  DateTime get generatedAt;

  /// Create a copy of RadarTimeline
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RadarTimelineImplCopyWith<_$RadarTimelineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
