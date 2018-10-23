// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consellation_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

consellationData _$consellationDataFromJson(Map<String, dynamic> json) {
  return consellationData(
      json['result1'] == null
          ? null
          : Result1.fromJson(json['result1'] as Map<String, dynamic>),
      json['error_code'] as int,
      json['reason'] as String);
}

Map<String, dynamic> _$consellationDataToJson(consellationData instance) =>
    <String, dynamic>{
      'result1': instance.result1,
      'error_code': instance.errorCode,
      'reason': instance.reason
    };

Result1 _$Result1FromJson(Map<String, dynamic> json) {
  return Result1(
      json['resultcode'] as String,
      json['error_code'] as String,
      json['name'] as String,
      json['datetime'] as String,
      json['date'] as String,
      json['all'] as String,
      json['color'] as String,
      json['health'] as String,
      json['love'] as String,
      json['money'] as String,
      json['number'] as String,
      json['QFriend'] as String,
      json['summary'] as String,
      json['work'] as String);
}

Map<String, dynamic> _$Result1ToJson(Result1 instance) => <String, dynamic>{
      'resultcode': instance.resultcode,
      'error_code': instance.errorCode,
      'name': instance.name,
      'datetime': instance.datetime,
      'date': instance.date,
      'all': instance.all,
      'color': instance.color,
      'health': instance.health,
      'love': instance.love,
      'money': instance.money,
      'number': instance.number,
      'QFriend': instance.qFriend,
      'summary': instance.summary,
      'work': instance.work
    };
