// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

dreamData _$dreamDataFromJson(Map<String, dynamic> json) {
  return dreamData(
      json['total'] as int,
      (json['result'] as List)
          ?.map((e) =>
              e == null ? null : Result.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['error_code'] as int,
      json['reason'] as String);
}

Map<String, dynamic> _$dreamDataToJson(dreamData instance) => <String, dynamic>{
      'total': instance.total,
      'result': instance.result,
      'error_code': instance.errorCode,
      'reason': instance.reason
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(json['title'] as String, json['content'] as String,
      json['type'] as String);
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'type': instance.type
    };
