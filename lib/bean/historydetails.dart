import 'package:json_annotation/json_annotation.dart';

part 'historydetails.g.dart';


@JsonSerializable()
class historydetails extends Object {

  @JsonKey(name: 'reason')
  String reason;

  @JsonKey(name: 'result')
  List<Result> result;

  @JsonKey(name: 'error_code')
  int errorCode;

  historydetails(this.reason,this.result,this.errorCode,);

  factory historydetails.fromJson(Map<String, dynamic> srcJson) => _$historydetailsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$historydetailsToJson(this);

}


@JsonSerializable()
class Result extends Object {

  @JsonKey(name: 'e_id')
  String eId;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'picNo')
  String picNo;

  @JsonKey(name: 'picUrl')
  List<PicUrl> picUrl;

  Result(this.eId,this.title,this.content,this.picNo,this.picUrl,);

  factory Result.fromJson(Map<String, dynamic> srcJson) => _$ResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

}


@JsonSerializable()
class PicUrl extends Object {

  @JsonKey(name: 'pic_title')
  String picTitle;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'url')
  String url;

  PicUrl(this.picTitle,this.id,this.url,);

  factory PicUrl.fromJson(Map<String, dynamic> srcJson) => _$PicUrlFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PicUrlToJson(this);

}