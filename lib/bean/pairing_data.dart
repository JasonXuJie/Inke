import 'package:json_annotation/json_annotation.dart';

part 'pairing_data.g.dart';


@JsonSerializable()
class pairingData extends Object {

  @JsonKey(name: 'result')
  Result result;

  @JsonKey(name: 'error_code')
  int errorCode;

  @JsonKey(name: 'reason')
  String reason;

  pairingData(this.result,this.errorCode,this.reason,);

  factory pairingData.fromJson(Map<String, dynamic> srcJson) => _$pairingDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$pairingDataToJson(this);

}


@JsonSerializable()
class Result extends Object {

  @JsonKey(name: 'xingzuo1')
  String xingzuo1;

  @JsonKey(name: 'xingzuo2')
  String xingzuo2;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'content1')
  String content1;

  @JsonKey(name: 'content2')
  String content2;

  Result(this.xingzuo1,this.xingzuo2,this.title,this.content1,this.content2,);

  factory Result.fromJson(Map<String, dynamic> srcJson) => _$ResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

}