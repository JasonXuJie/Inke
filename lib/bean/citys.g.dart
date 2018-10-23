// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'citys.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

citys _$citysFromJson(Map<String, dynamic> json) {
  return citys(
      json['count'] as int,
      json['start'] as int,
      json['total'] as int,
      (json['locs'] as List)
          ?.map((e) =>
              e == null ? null : Locs.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$citysToJson(citys instance) => <String, dynamic>{
      'count': instance.count,
      'start': instance.start,
      'total': instance.total,
      'locs': instance.locs
    };

Locs _$LocsFromJson(Map<String, dynamic> json) {
  return Locs(json['parent'] as String, json['habitable'] as String,
      json['id'] as String, json['name'] as String, json['uid'] as String);
}

Map<String, dynamic> _$LocsToJson(Locs instance) => <String, dynamic>{
      'parent': instance.parent,
      'habitable': instance.habitable,
      'id': instance.id,
      'name': instance.name,
      'uid': instance.uid
    };
