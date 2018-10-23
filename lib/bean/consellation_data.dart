import 'package:json_annotation/json_annotation.dart';

part 'consellation_data.g.dart';


@JsonSerializable()
class consellationData extends Object {

  @JsonKey(name: 'result1')
  Result1 result1;

  @JsonKey(name: 'error_code')
  int errorCode;

  @JsonKey(name: 'reason')
  String reason;

  consellationData(this.result1,this.errorCode,this.reason,);

  factory consellationData.fromJson(Map<String, dynamic> srcJson) => _$consellationDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$consellationDataToJson(this);

}


@JsonSerializable()
class Result1 extends Object {

  @JsonKey(name: 'resultcode')
  String resultcode;

  @JsonKey(name: 'error_code')
  String errorCode;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'datetime')
  String datetime;

  @JsonKey(name: 'date')
  String date;

  @JsonKey(name: 'all')
  String all;

  @JsonKey(name: 'color')
  String color;

  @JsonKey(name: 'health')
  String health;

  @JsonKey(name: 'love')
  String love;

  @JsonKey(name: 'money')
  String money;

  @JsonKey(name: 'number')
  String number;

  @JsonKey(name: 'QFriend')
  String qFriend;

  @JsonKey(name: 'summary')
  String summary;

  @JsonKey(name: 'work')
  String work;

  Result1(this.resultcode,this.errorCode,this.name,this.datetime,this.date,this.all,this.color,this.health,this.love,this.money,this.number,this.qFriend,this.summary,this.work,);

  factory Result1.fromJson(Map<String, dynamic> srcJson) => _$Result1FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Result1ToJson(this);

}