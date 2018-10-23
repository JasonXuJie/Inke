import 'package:json_annotation/json_annotation.dart';

part 'moviedetails.g.dart';


@JsonSerializable()
class moviedetails extends Object {

  @JsonKey(name: 'rating')
  Rating rating;

  @JsonKey(name: 'reviews_count')
  int reviewsCount;

  @JsonKey(name: 'wish_count')
  int wishCount;

  @JsonKey(name: 'douban_site')
  String doubanSite;

  @JsonKey(name: 'year')
  String year;

  @JsonKey(name: 'images')
  Images images;

  @JsonKey(name: 'alt')
  String alt;

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'mobile_url')
  String mobileUrl;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'share_url')
  String shareUrl;

  @JsonKey(name: 'schedule_url')
  String scheduleUrl;

  @JsonKey(name: 'countries')
  List<String> countries;

  @JsonKey(name: 'genres')
  List<String> genres;

  @JsonKey(name: 'collect_count')
  int collectCount;

  @JsonKey(name: 'casts')
  List<Casts> casts;

  @JsonKey(name: 'original_title')
  String originalTitle;

  @JsonKey(name: 'summary')
  String summary;

  @JsonKey(name: 'subtype')
  String subtype;

  @JsonKey(name: 'directors')
  List<Directors> directors;

  @JsonKey(name: 'comments_count')
  int commentsCount;

  @JsonKey(name: 'ratings_count')
  int ratingsCount;

  @JsonKey(name: 'aka')
  List<String> aka;

  moviedetails(this.rating,this.reviewsCount,this.wishCount,this.doubanSite,this.year,this.images,this.alt,this.id,this.mobileUrl,this.title,this.shareUrl,this.scheduleUrl,this.countries,this.genres,this.collectCount,this.casts,this.originalTitle,this.summary,this.subtype,this.directors,this.commentsCount,this.ratingsCount,this.aka,);

  factory moviedetails.fromJson(Map<String, dynamic> srcJson) => _$moviedetailsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$moviedetailsToJson(this);

}


@JsonSerializable()
class Rating extends Object {

  @JsonKey(name: 'max')
  int max;

  @JsonKey(name: 'average')
  double average;

  @JsonKey(name: 'stars')
  String stars;

  @JsonKey(name: 'min')
  int min;

  Rating(this.max,this.average,this.stars,this.min,);

  factory Rating.fromJson(Map<String, dynamic> srcJson) => _$RatingFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RatingToJson(this);

}


@JsonSerializable()
class Images extends Object {

  @JsonKey(name: 'small')
  String small;

  @JsonKey(name: 'large')
  String large;

  @JsonKey(name: 'medium')
  String medium;

  Images(this.small,this.large,this.medium,);

  factory Images.fromJson(Map<String, dynamic> srcJson) => _$ImagesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ImagesToJson(this);

}


@JsonSerializable()
class Casts extends Object {

  @JsonKey(name: 'alt')
  String alt;

  @JsonKey(name: 'avatars')
  Avatars avatars;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'id')
  String id;

  Casts(this.alt,this.avatars,this.name,this.id,);

  factory Casts.fromJson(Map<String, dynamic> srcJson) => _$CastsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CastsToJson(this);

}


@JsonSerializable()
class Avatars extends Object {

  @JsonKey(name: 'small')
  String small;

  @JsonKey(name: 'large')
  String large;

  @JsonKey(name: 'medium')
  String medium;

  Avatars(this.small,this.large,this.medium,);

  factory Avatars.fromJson(Map<String, dynamic> srcJson) => _$AvatarsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AvatarsToJson(this);

}


@JsonSerializable()
class Directors extends Object {

  @JsonKey(name: 'alt')
  String alt;

  @JsonKey(name: 'avatars')
  Avatars avatars;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'id')
  String id;

  Directors(this.alt,this.avatars,this.name,this.id,);

  factory Directors.fromJson(Map<String, dynamic> srcJson) => _$DirectorsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DirectorsToJson(this);

}


//@JsonSerializable()
//class Avatars extends Object {
//
//  @JsonKey(name: 'small')
//  String small;
//
//  @JsonKey(name: 'large')
//  String large;
//
//  @JsonKey(name: 'medium')
//  String medium;
//
//  Avatars(this.small,this.large,this.medium,);
//
//  factory Avatars.fromJson(Map<String, dynamic> srcJson) => _$AvatarsFromJson(srcJson);
//
//  Map<String, dynamic> toJson() => _$AvatarsToJson(this);
//
//}