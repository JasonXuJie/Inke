import 'package:flutter/material.dart';

class DateTypeProvider with ChangeNotifier{

  String _dateType = 'future';

  String get dateType => _dateType;

  void setType(String type){
    _dateType = type;
    notifyListeners();
  }

}