import 'package:json_annotation/json_annotation.dart';

part 'citys.g.dart';


@JsonSerializable()
class citys extends Object {

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'start')
  int start;

  @JsonKey(name: 'total')
  int total;

  @JsonKey(name: 'locs')
  List<Locs> locs;

  citys(this.count,this.start,this.total,this.locs,);

  factory citys.fromJson(Map<String, dynamic> srcJson) => _$citysFromJson(srcJson);

  Map<String, dynamic> toJson() => _$citysToJson(this);

}


@JsonSerializable()
class Locs extends Object {

  @JsonKey(name: 'parent')
  String parent;

  @JsonKey(name: 'habitable')
  String habitable;

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'uid')
  String uid;

  Locs(this.parent,this.habitable,this.id,this.name,this.uid,);

  factory Locs.fromJson(Map<String, dynamic> srcJson) => _$LocsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LocsToJson(this);

}