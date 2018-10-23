// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pairing_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

pairingData _$pairingDataFromJson(Map<String, dynamic> json) {
  return pairingData(
      json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      json['error_code'] as int,
      json['reason'] as String);
}

Map<String, dynamic> _$pairingDataToJson(pairingData instance) =>
    <String, dynamic>{
      'result': instance.result,
      'error_code': instance.errorCode,
      'reason': instance.reason
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
      json['xingzuo1'] as String,
      json['xingzuo2'] as String,
      json['title'] as String,
      json['content1'] as String,
      json['content2'] as String);
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'xingzuo1': instance.xingzuo1,
      'xingzuo2': instance.xingzuo2,
      'title': instance.title,
      'content1': instance.content1,
      'content2': instance.content2
    };
