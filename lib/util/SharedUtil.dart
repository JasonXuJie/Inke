import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SharedUtil {

  static SharedUtil _instance;
  SharedPreferences preferences;


  static SharedUtil getInstance() {
    if (_instance == null) {
      _instance = SharedUtil();
    }
    return _instance;
  }



  init() async {
    preferences = await SharedPreferences.getInstance();
  }


  Future<Null> put(String key,dynamic value)async{
    if(value is String){
      await preferences.setString(key, value);
    }else if(value is double){
      await preferences.setDouble(key, value);
    }else if(value is int){
      await preferences.setInt(key, value);
    }else if(value is bool){
      await preferences.setBool(key, value);
    }else if(value is List<String>){
      await preferences.setStringList(key, value);
    }else{
      await preferences.setString(key, value.toString());
    }
  }

  dynamic get(String key,dynamic defVal){
    if(defVal is String){
      String value = preferences.getString(key);
      if(value==null){
        put(key, defVal);
        return defVal;
      }else{
        return value;
      }
    }else if(defVal is double){
      double value = preferences.getDouble(key);
      if(value == null){
        put(key, defVal);
        return defVal;
      }else{
        return value;
      }
    }else if(defVal is int){
      int value = preferences.getInt(key);
      if(value==null){
        put(key, defVal);
        return defVal;
      }else{
        return value;
      }
    }else if(defVal is bool){
      bool value = preferences.getBool(key);
      if(value == null){
        put(key, defVal);
        return defVal;
      }else{
        return value;
      }
    }else if(defVal is List<String>){
      List<String> value = preferences.getStringList(key);
      if(value == null){
        put(key, defVal);
        return defVal;
      }else{
        return value;
      }
    }else{
      preferences.get(key);
    }
  }


  Future<bool> clear(){
    return preferences.clear();
  }

  Future<bool> remove(String key){
    return preferences.remove(key);
  }

}
