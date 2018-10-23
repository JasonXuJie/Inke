import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SharedUtil {
  static SharedUtil _instance;
  SharedPreferences preferences;
  static final String CITY_NAME = 'cityName';
  static final String CITY_ID = 'cityId';

  static SharedUtil getInstance() {
    if (_instance == null) {
      _instance = SharedUtil();
    }
    return _instance;
  }



  init() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<Null> saveCity(String name, String id) async {
    await preferences.setString(CITY_NAME, name);
    await preferences.setString(CITY_ID, id);
  }

  Map<String,String> getCity(){
    Map<String, String> map = Map();
    map[CITY_NAME] = preferences.getString(CITY_NAME);
    map[CITY_ID] = preferences.getString(CITY_ID);
    return map;
  }
}
