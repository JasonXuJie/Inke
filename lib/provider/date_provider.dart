import 'package:flutter/material.dart';

class DateType extends ChangeNotifier{

  String _dateType = 'future';


  get dateType => _dateType;


  void setType(String type){
    this._dateType = type;
    notifyListeners();
  }


}