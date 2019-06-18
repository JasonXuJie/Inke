import 'package:flutter/material.dart';
import 'package:Inke/util/shared_util.dart';
import 'package:Inke/config/shared_key.dart';

class CityProvider with ChangeNotifier {

  var _name;
  var _id;

  CityProvider() {
    _name = SharedUtil.getInstance().get(SharedKey.cityName, '上海');
    _id = SharedUtil.getInstance().get(SharedKey.cityId, '108296');
  }

  void setName(String name) {
    _name = name;
    SharedUtil.getInstance().put(SharedKey.cityName, name);
    notifyListeners();
  }

  void setId(String id) {
    _id = id;
    SharedUtil.getInstance().put(SharedKey.cityId, id);
    notifyListeners();
  }

  String get name => _name;

  String get id => _id;
}
