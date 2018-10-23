// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

newsData _$newsDataFromJson(Map<String, dynamic> json) {
  return newsData(
      json['reason'] as String,
      json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      json['error_code'] as int);
}

Map<String, dynamic> _$newsDataToJson(newsData instance) => <String, dynamic>{
      'reason': instance.reason,
      'result': instance.result,
      'error_code': instance.errorCode
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
      json['stat'] as String,
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : Data.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ResultToJson(Result instance) =>
    <String, dynamic>{'stat': instance.stat, 'data': instance.data};

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      json['uniquekey'] as String,
      json['title'] as String,
      json['date'] as String,
      json['category'] as String,
      json['author_name'] as String,
      json['url'] as String,
      json['thumbnail_pic_s'] as String);
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'uniquekey': instance.uniquekey,
      'title': instance.title,
      'date': instance.date,
      'category': instance.category,
      'author_name': instance.authorName,
      'url': instance.url,
      'thumbnail_pic_s': instance.thumbnailPicS
    };
