import 'package:flutter/material.dart';
import 'package:Inke/router/application.dart';


class NavigatorUtil{

  ///跳转
  static Future<dynamic> push(BuildContext context,String name){
    return Application.router.navigateTo(context, name);
  }

  ///跳转并销毁自身
  static void pushAndReplace(BuildContext context,String name){
    Application.router.navigateTo(context, name,replace: true);
  }

  ///返回
  static void goBack(BuildContext context){
    Navigator.of(context).pop();
  }

  ///带参数返回
  static void goBackByParams(BuildContext context,dynamic result){
    Navigator.of(context).pop(result);
  }

  ///跳转并返回参数
  static void pushResult(BuildContext context,String name,Function function){
    Application.router.navigateTo(context, name).then((result){
        if(result == null){
          return;
        }
        function(result);
    }).catchError((error){
      print('$error');
    });
  }


  ///跳转并销毁所有页面
  static void pushAndRemoveAll(BuildContext context,String name){
    Application.router.navigateTo(context, name,clearStack: true);
  }

}