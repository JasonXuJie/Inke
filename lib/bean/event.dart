import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';


@JsonSerializable()
class event extends Object {

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'start')
  int start;

  @JsonKey(name: 'districts')
  List<Districts> districts;

  @JsonKey(name: 'total')
  int total;

  @JsonKey(name: 'events')
  List<Events> events;

  event(this.count,this.start,this.districts,this.total,this.events,);

  factory event.fromJson(Map<String, dynamic> srcJson) => _$eventFromJson(srcJson);

  Map<String, dynamic> toJson() => _$eventToJson(this);

}


@JsonSerializable()
class Districts extends Object {

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'id')
  String id;

  Districts(this.name,this.id,);

  factory Districts.fromJson(Map<String, dynamic> srcJson) => _$DistrictsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DistrictsToJson(this);

}


@JsonSerializable()
class Events extends Object {

  @JsonKey(name: 'image')
  String image;

  @JsonKey(name: 'adapt_url')
  String adaptUrl;

  @JsonKey(name: 'loc_name')
  String locName;

  @JsonKey(name: 'owner')
  Owner owner;

  @JsonKey(name: 'alt')
  String alt;

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'category')
  String category;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'wisher_count')
  int wisherCount;

  @JsonKey(name: 'has_ticket')
  bool hasTicket;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'can_invite')
  String canInvite;

  @JsonKey(name: 'time_str')
  String timeStr;

  @JsonKey(name: 'album')
  String album;

  @JsonKey(name: 'participant_count')
  int participantCount;

  @JsonKey(name: 'tags')
  String tags;

  @JsonKey(name: 'image_hlarge')
  String imageHlarge;

  @JsonKey(name: 'begin_time')
  String beginTime;

  @JsonKey(name: 'price_range')
  String priceRange;

  @JsonKey(name: 'geo')
  String geo;

  @JsonKey(name: 'image_lmobile')
  String imageLmobile;

  @JsonKey(name: 'category_name')
  String categoryName;

  @JsonKey(name: 'loc_id')
  String locId;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'uri')
  String uri;

  @JsonKey(name: 'fee_str')
  String feeStr;

  @JsonKey(name: 'end_time')
  String endTime;

  @JsonKey(name: 'address')
  String address;

  Events(this.image,this.adaptUrl,this.locName,this.owner,this.alt,this.id,this.category,this.title,this.wisherCount,this.hasTicket,this.content,this.canInvite,this.timeStr,this.album,this.participantCount,this.tags,this.imageHlarge,this.beginTime,this.priceRange,this.geo,this.imageLmobile,this.categoryName,this.locId,this.url,this.uri,this.feeStr,this.endTime,this.address,);

  factory Events.fromJson(Map<String, dynamic> srcJson) => _$EventsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EventsToJson(this);

}


@JsonSerializable()
class Owner extends Object {

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'is_banned')
  bool isBanned;

  @JsonKey(name: 'is_suicide')
  bool isSuicide;

  @JsonKey(name: 'avatar')
  String avatar;

  @JsonKey(name: 'uid')
  String uid;

  @JsonKey(name: 'alt')
  String alt;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'large_avatar')
  String largeAvatar;

  Owner(this.name,this.isBanned,this.isSuicide,this.avatar,this.uid,this.alt,this.type,this.id,this.largeAvatar,);

  factory Owner.fromJson(Map<String, dynamic> srcJson) => _$OwnerFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OwnerToJson(this);

}
