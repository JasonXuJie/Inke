import 'package:flutter/material.dart';
import 'package:Inke/config/shared_key.dart';
import 'package:flustars/flustars.dart';

class CityProvider extends ChangeNotifier {

  var _name;
  var _id;

  CityProvider() {
    _name = SpUtil.getString(SharedKey.cityName,defValue: '上海');
    _id = SpUtil.getString(SharedKey.cityId,defValue: '108296');
  }

  void setName(String name) {
    _name = name;
    SpUtil.putString(SharedKey.cityName, _name);
    notifyListeners();
  }

  void setId(String id) {
    _id = id;
    SpUtil.putString(SharedKey.cityId, _id);
    notifyListeners();
  }


  void setCity(String id,String name){
    _name = name;
    _id = id;
    SpUtil.putString(SharedKey.cityName, _name);
    SpUtil.putString(SharedKey.cityId, _id);
    notifyListeners();
  }

  String get name => _name;

  String get id => _id;
}
