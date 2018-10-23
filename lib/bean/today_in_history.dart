import 'package:json_annotation/json_annotation.dart';

part 'today_in_history.g.dart';


@JsonSerializable()
class todayInHistory extends Object {

  @JsonKey(name: 'reason')
  String reason;

  @JsonKey(name: 'result')
  List<Result> result;

  @JsonKey(name: 'error_code')
  int errorCode;

  todayInHistory(this.reason,this.result,this.errorCode,);

  factory todayInHistory.fromJson(Map<String, dynamic> srcJson) => _$todayInHistoryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$todayInHistoryToJson(this);

}


@JsonSerializable()
class Result extends Object {

  @JsonKey(name: 'day')
  String day;

  @JsonKey(name: 'date')
  String date;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'e_id')
  String eId;

  Result(this.day,this.date,this.title,this.eId,);

  factory Result.fromJson(Map<String, dynamic> srcJson) => _$ResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

}