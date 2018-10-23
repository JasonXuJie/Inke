// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_in_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

todayInHistory _$todayInHistoryFromJson(Map<String, dynamic> json) {
  return todayInHistory(
      json['reason'] as String,
      (json['result'] as List)
          ?.map((e) =>
              e == null ? null : Result.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['error_code'] as int);
}

Map<String, dynamic> _$todayInHistoryToJson(todayInHistory instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'result': instance.result,
      'error_code': instance.errorCode
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(json['day'] as String, json['date'] as String,
      json['title'] as String, json['e_id'] as String);
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'day': instance.day,
      'date': instance.date,
      'title': instance.title,
      'e_id': instance.eId
    };
