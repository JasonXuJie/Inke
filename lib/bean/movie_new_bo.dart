import 'package:json_annotation/json_annotation.dart';

part 'movie_new_bo.g.dart';


@JsonSerializable()
class movieNewBo extends Object {

  @JsonKey(name: 'result')
  List<Result> result;

  @JsonKey(name: 'error_code')
  int errorCode;

  @JsonKey(name: 'reason')
  String reason;

  movieNewBo(this.result,this.errorCode,this.reason,);

  factory movieNewBo.fromJson(Map<String, dynamic> srcJson) => _$movieNewBoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$movieNewBoToJson(this);

}


@JsonSerializable()
class Result extends Object {

  @JsonKey(name: 'rid')
  String rid;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'wk')
  String wk;

  @JsonKey(name: 'wboxoffice')
  String wboxoffice;

  @JsonKey(name: 'tboxoffice')
  String tboxoffice;

  Result(this.rid,this.name,this.wk,this.wboxoffice,this.tboxoffice,);

  factory Result.fromJson(Map<String, dynamic> srcJson) => _$ResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

}