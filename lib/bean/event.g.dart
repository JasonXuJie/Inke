// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

event _$eventFromJson(Map<String, dynamic> json) {
  return event(
      json['count'] as int,
      json['start'] as int,
      (json['districts'] as List)
          ?.map((e) =>
              e == null ? null : Districts.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['total'] as int,
      (json['events'] as List)
          ?.map((e) =>
              e == null ? null : Events.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$eventToJson(event instance) => <String, dynamic>{
      'count': instance.count,
      'start': instance.start,
      'districts': instance.districts,
      'total': instance.total,
      'events': instance.events
    };

Districts _$DistrictsFromJson(Map<String, dynamic> json) {
  return Districts(json['name'] as String, json['id'] as String);
}

Map<String, dynamic> _$DistrictsToJson(Districts instance) =>
    <String, dynamic>{'name': instance.name, 'id': instance.id};

Events _$EventsFromJson(Map<String, dynamic> json) {
  return Events(
      json['image'] as String,
      json['adapt_url'] as String,
      json['loc_name'] as String,
      json['owner'] == null
          ? null
          : Owner.fromJson(json['owner'] as Map<String, dynamic>),
      json['alt'] as String,
      json['id'] as String,
      json['category'] as String,
      json['title'] as String,
      json['wisher_count'] as int,
      json['has_ticket'] as bool,
      json['content'] as String,
      json['can_invite'] as String,
      json['time_str'] as String,
      json['album'] as String,
      json['participant_count'] as int,
      json['tags'] as String,
      json['image_hlarge'] as String,
      json['begin_time'] as String,
      json['price_range'] as String,
      json['geo'] as String,
      json['image_lmobile'] as String,
      json['category_name'] as String,
      json['loc_id'] as String,
      json['url'] as String,
      json['uri'] as String,
      json['fee_str'] as String,
      json['end_time'] as String,
      json['address'] as String);
}

Map<String, dynamic> _$EventsToJson(Events instance) => <String, dynamic>{
      'image': instance.image,
      'adapt_url': instance.adaptUrl,
      'loc_name': instance.locName,
      'owner': instance.owner,
      'alt': instance.alt,
      'id': instance.id,
      'category': instance.category,
      'title': instance.title,
      'wisher_count': instance.wisherCount,
      'has_ticket': instance.hasTicket,
      'content': instance.content,
      'can_invite': instance.canInvite,
      'time_str': instance.timeStr,
      'album': instance.album,
      'participant_count': instance.participantCount,
      'tags': instance.tags,
      'image_hlarge': instance.imageHlarge,
      'begin_time': instance.beginTime,
      'price_range': instance.priceRange,
      'geo': instance.geo,
      'image_lmobile': instance.imageLmobile,
      'category_name': instance.categoryName,
      'loc_id': instance.locId,
      'url': instance.url,
      'uri': instance.uri,
      'fee_str': instance.feeStr,
      'end_time': instance.endTime,
      'address': instance.address
    };

Owner _$OwnerFromJson(Map<String, dynamic> json) {
  return Owner(
      json['name'] as String,
      json['is_banned'] as bool,
      json['is_suicide'] as bool,
      json['avatar'] as String,
      json['uid'] as String,
      json['alt'] as String,
      json['type'] as String,
      json['id'] as String,
      json['large_avatar'] as String);
}

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
      'name': instance.name,
      'is_banned': instance.isBanned,
      'is_suicide': instance.isSuicide,
      'avatar': instance.avatar,
      'uid': instance.uid,
      'alt': instance.alt,
      'type': instance.type,
      'id': instance.id,
      'large_avatar': instance.largeAvatar
    };
