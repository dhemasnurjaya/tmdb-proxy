// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RequestBodyImpl _$$RequestBodyImplFromJson(Map<String, dynamic> json) =>
    _$RequestBodyImpl(
      path: json['path'] as String,
      queries: json['queries'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$RequestBodyImplToJson(_$RequestBodyImpl instance) =>
    <String, dynamic>{
      'path': instance.path,
      'queries': instance.queries,
    };
