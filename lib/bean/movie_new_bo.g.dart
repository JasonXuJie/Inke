// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_new_bo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

movieNewBo _$movieNewBoFromJson(Map<String, dynamic> json) {
  return movieNewBo(
      (json['result'] as List)
          ?.map((e) =>
              e == null ? null : Result.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['error_code'] as int,
      json['reason'] as String);
}

Map<String, dynamic> _$movieNewBoToJson(movieNewBo instance) =>
    <String, dynamic>{
      'result': instance.result,
      'error_code': instance.errorCode,
      'reason': instance.reason
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
      json['rid'] as String,
      json['name'] as String,
      json['wk'] as String,
      json['wboxoffice'] as String,
      json['tboxoffice'] as String);
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'rid': instance.rid,
      'name': instance.name,
      'wk': instance.wk,
      'wboxoffice': instance.wboxoffice,
      'tboxoffice': instance.tboxoffice
    };
