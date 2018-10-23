// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

music _$musicFromJson(Map<String, dynamic> json) {
  return music(
      json['count'] as int,
      json['start'] as int,
      json['total'] as int,
      (json['musics'] as List)
          ?.map((e) =>
              e == null ? null : Musics.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$musicToJson(music instance) => <String, dynamic>{
      'count': instance.count,
      'start': instance.start,
      'total': instance.total,
      'musics': instance.musics
    };

Musics _$MusicsFromJson(Map<String, dynamic> json) {
  return Musics(
      json['rating'] == null
          ? null
          : Rating.fromJson(json['rating'] as Map<String, dynamic>),
      (json['author'] as List)
          ?.map((e) =>
              e == null ? null : Author.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['alt_title'] as String,
      json['image'] as String,
      (json['tags'] as List)
          ?.map((e) =>
              e == null ? null : Tags.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['mobile_link'] as String,
      json['attrs'] == null
          ? null
          : Attrs.fromJson(json['attrs'] as Map<String, dynamic>),
      json['title'] as String,
      json['alt'] as String,
      json['id'] as String);
}

Map<String, dynamic> _$MusicsToJson(Musics instance) => <String, dynamic>{
      'rating': instance.rating,
      'author': instance.author,
      'alt_title': instance.altTitle,
      'image': instance.image,
      'tags': instance.tags,
      'mobile_link': instance.mobileLink,
      'attrs': instance.attrs,
      'title': instance.title,
      'alt': instance.alt,
      'id': instance.id
    };

Rating _$RatingFromJson(Map<String, dynamic> json) {
  return Rating(json['max'] as int, json['average'] as String,
      json['numRaters'] as int, json['min'] as int);
}

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'max': instance.max,
      'average': instance.average,
      'numRaters': instance.numRaters,
      'min': instance.min
    };

Author _$AuthorFromJson(Map<String, dynamic> json) {
  return Author(json['name'] as String);
}

Map<String, dynamic> _$AuthorToJson(Author instance) =>
    <String, dynamic>{'name': instance.name};

Tags _$TagsFromJson(Map<String, dynamic> json) {
  return Tags(json['count'] as int, json['name'] as String);
}

Map<String, dynamic> _$TagsToJson(Tags instance) =>
    <String, dynamic>{'count': instance.count, 'name': instance.name};

Attrs _$AttrsFromJson(Map<String, dynamic> json) {
  return Attrs(
      (json['publisher'] as List)?.map((e) => e as String)?.toList(),
      (json['singer'] as List)?.map((e) => e as String)?.toList(),
      (json['version'] as List)?.map((e) => e as String)?.toList(),
      (json['pubdate'] as List)?.map((e) => e as String)?.toList(),
      (json['title'] as List)?.map((e) => e as String)?.toList(),
      (json['media'] as List)?.map((e) => e as String)?.toList(),
      (json['tracks'] as List)?.map((e) => e as String)?.toList(),
      (json['discs'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$AttrsToJson(Attrs instance) => <String, dynamic>{
      'publisher': instance.publisher,
      'singer': instance.singer,
      'version': instance.version,
      'pubdate': instance.pubdate,
      'title': instance.title,
      'media': instance.media,
      'tracks': instance.tracks,
      'discs': instance.discs
    };
