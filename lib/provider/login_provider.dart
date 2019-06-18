import 'package:Inke/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:Inke/config/shared_key.dart';
import 'package:Inke/util/shared_util.dart';

class LoginProvider with ChangeNotifier{


  bool _isLogin;

  LoginProvider(){
    _isLogin = SharedUtil.getInstance().get(SharedKey.isLogin, false);
  }


  bool get isLogin => _isLogin;

  void hasLogin(bool flag){
    _isLogin = flag;
    SharedUtil.getInstance().put(SharedKey.isLogin, flag);
    notifyListeners();

  }
}