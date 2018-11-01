import 'package:flutter/material.dart';
class FunItem{
  String title;
  String subTitle;
  MaterialAccentColor colors;

  FunItem(this.title,this.subTitle,this.colors);

  String get getTitle=>this.title;
}