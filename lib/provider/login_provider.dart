import 'package:flutter/material.dart';
import 'package:Inke/config/shared_key.dart';
import 'package:flustars/flustars.dart';

class LoginProvider extends ChangeNotifier{


  bool _isLogin;

  LoginProvider(){
    _isLogin = SpUtil.getBool(SharedKey.isLogin,defValue: false);
  }


  bool get isLogin => _isLogin;

  void hasLogin(bool flag){
    _isLogin = flag;
    SpUtil.putBool(SharedKey.isLogin, flag);
    notifyListeners();

  }
}