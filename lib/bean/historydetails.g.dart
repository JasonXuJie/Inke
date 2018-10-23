// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historydetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

historydetails _$historydetailsFromJson(Map<String, dynamic> json) {
  return historydetails(
      json['reason'] as String,
      (json['result'] as List)
          ?.map((e) =>
              e == null ? null : Result.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['error_code'] as int);
}

Map<String, dynamic> _$historydetailsToJson(historydetails instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'result': instance.result,
      'error_code': instance.errorCode
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
      json['e_id'] as String,
      json['title'] as String,
      json['content'] as String,
      json['picNo'] as String,
      (json['picUrl'] as List)
          ?.map((e) =>
              e == null ? null : PicUrl.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'e_id': instance.eId,
      'title': instance.title,
      'content': instance.content,
      'picNo': instance.picNo,
      'picUrl': instance.picUrl
    };

PicUrl _$PicUrlFromJson(Map<String, dynamic> json) {
  return PicUrl(
      json['pic_title'] as String, json['id'] as int, json['url'] as String);
}

Map<String, dynamic> _$PicUrlToJson(PicUrl instance) => <String, dynamic>{
      'pic_title': instance.picTitle,
      'id': instance.id,
      'url': instance.url
    };
