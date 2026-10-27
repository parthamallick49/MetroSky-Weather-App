// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radar_frame.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RadarFrameImpl _$$RadarFrameImplFromJson(Map<String, dynamic> json) =>
    _$RadarFrameImpl(
      timestamp: (json['timestamp'] as num).toInt(),
      path: json['path'] as String,
      isNowcast: json['isNowcast'] as bool,
    );

Map<String, dynamic> _$$RadarFrameImplToJson(_$RadarFrameImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'path': instance.path,
      'isNowcast': instance.isNowcast,
    };

_$RadarTimelineImpl _$$RadarTimelineImplFromJson(Map<String, dynamic> json) =>
    _$RadarTimelineImpl(
      host: json['host'] as String,
      pastFrames: (json['pastFrames'] as List<dynamic>)
          .map((e) => RadarFrame.fromJson(e as Map<String, dynamic>))
          .toList(),
      nowcastFrames: (json['nowcastFrames'] as List<dynamic>)
          .map((e) => RadarFrame.fromJson(e as Map<String, dynamic>))
          .toList(),
      generatedAt: DateTime.parse(json['generatedAt'] as String),
    );

Map<String, dynamic> _$$RadarTimelineImplToJson(_$RadarTimelineImpl instance) =>
    <String, dynamic>{
      'host': instance.host,
      'pastFrames': instance.pastFrames,
      'nowcastFrames': instance.nowcastFrames,
      'generatedAt': instance.generatedAt.toIso8601String(),
    };
