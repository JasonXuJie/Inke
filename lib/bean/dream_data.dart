import 'package:json_annotation/json_annotation.dart';

part 'dream_data.g.dart';


@JsonSerializable()
class dreamData extends Object {

  @JsonKey(name: 'total')
  int total;

  @JsonKey(name: 'result')
  List<Result> result;

  @JsonKey(name: 'error_code')
  int errorCode;

  @JsonKey(name: 'reason')
  String reason;

  dreamData(this.total,this.result,this.errorCode,this.reason,);

  factory dreamData.fromJson(Map<String, dynamic> srcJson) => _$dreamDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$dreamDataToJson(this);

}


@JsonSerializable()
class Result extends Object {

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'type')
  String type;

  Result(this.title,this.content,this.type,);

  factory Result.fromJson(Map<String, dynamic> srcJson) => _$ResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

}