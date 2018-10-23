// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moviedetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

moviedetails _$moviedetailsFromJson(Map<String, dynamic> json) {
  return moviedetails(
      json['rating'] == null
          ? null
          : Rating.fromJson(json['rating'] as Map<String, dynamic>),
      json['reviews_count'] as int,
      json['wish_count'] as int,
      json['douban_site'] as String,
      json['year'] as String,
      json['images'] == null
          ? null
          : Images.fromJson(json['images'] as Map<String, dynamic>),
      json['alt'] as String,
      json['id'] as String,
      json['mobile_url'] as String,
      json['title'] as String,
      json['share_url'] as String,
      json['schedule_url'] as String,
      (json['countries'] as List)?.map((e) => e as String)?.toList(),
      (json['genres'] as List)?.map((e) => e as String)?.toList(),
      json['collect_count'] as int,
      (json['casts'] as List)
          ?.map((e) =>
              e == null ? null : Casts.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['original_title'] as String,
      json['summary'] as String,
      json['subtype'] as String,
      (json['directors'] as List)
          ?.map((e) =>
              e == null ? null : Directors.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['comments_count'] as int,
      json['ratings_count'] as int,
      (json['aka'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$moviedetailsToJson(moviedetails instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'reviews_count': instance.reviewsCount,
      'wish_count': instance.wishCount,
      'douban_site': instance.doubanSite,
      'year': instance.year,
      'images': instance.images,
      'alt': instance.alt,
      'id': instance.id,
      'mobile_url': instance.mobileUrl,
      'title': instance.title,
      'share_url': instance.shareUrl,
      'schedule_url': instance.scheduleUrl,
      'countries': instance.countries,
      'genres': instance.genres,
      'collect_count': instance.collectCount,
      'casts': instance.casts,
      'original_title': instance.originalTitle,
      'summary': instance.summary,
      'subtype': instance.subtype,
      'directors': instance.directors,
      'comments_count': instance.commentsCount,
      'ratings_count': instance.ratingsCount,
      'aka': instance.aka
    };

Rating _$RatingFromJson(Map<String, dynamic> json) {
  return Rating(json['max'] as int, (json['average'] as num)?.toDouble(),
      json['stars'] as String, json['min'] as int);
}

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'max': instance.max,
      'average': instance.average,
      'stars': instance.stars,
      'min': instance.min
    };

Images _$ImagesFromJson(Map<String, dynamic> json) {
  return Images(json['small'] as String, json['large'] as String,
      json['medium'] as String);
}

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
      'small': instance.small,
      'large': instance.large,
      'medium': instance.medium
    };

Casts _$CastsFromJson(Map<String, dynamic> json) {
  return Casts(
      json['alt'] as String,
      json['avatars'] == null
          ? null
          : Avatars.fromJson(json['avatars'] as Map<String, dynamic>),
      json['name'] as String,
      json['id'] as String);
}

Map<String, dynamic> _$CastsToJson(Casts instance) => <String, dynamic>{
      'alt': instance.alt,
      'avatars': instance.avatars,
      'name': instance.name,
      'id': instance.id
    };

Avatars _$AvatarsFromJson(Map<String, dynamic> json) {
  return Avatars(json['small'] as String, json['large'] as String,
      json['medium'] as String);
}

Map<String, dynamic> _$AvatarsToJson(Avatars instance) => <String, dynamic>{
      'small': instance.small,
      'large': instance.large,
      'medium': instance.medium
    };

Directors _$DirectorsFromJson(Map<String, dynamic> json) {
  return Directors(
      json['alt'] as String,
      json['avatars'] == null
          ? null
          : Avatars.fromJson(json['avatars'] as Map<String, dynamic>),
      json['name'] as String,
      json['id'] as String);
}

Map<String, dynamic> _$DirectorsToJson(Directors instance) => <String, dynamic>{
      'alt': instance.alt,
      'avatars': instance.avatars,
      'name': instance.name,
      'id': instance.id
    };
