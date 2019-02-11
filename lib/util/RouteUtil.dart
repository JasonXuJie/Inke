import 'package:flutter/material.dart';


//跳转工具类
class RouteUtil {

  ///跳转新界面
  ///参数：上下文，新界面name
  static Future<dynamic> pushByNamed(BuildContext context, String routeName) {
    return Navigator.pushNamed(context, routeName);
  }

  ///跳转新界面
  ///参数：上下文，指定widget界面
  static Future<dynamic> pushByWidget(BuildContext context, Widget widget) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => widget));
  }

  ///跳转新界面并将自己移除(可以获取新界面的返回值)
  ///pushReplacementNamed，popAndPushNamed，pushReplacement
  static Future<dynamic> popAndPushByNamed(BuildContext context,
      String routeName) {
    return Navigator.of(context).pushReplacementNamed(routeName);
  }
  ///返回会有黑影
//  static Future<dynamic> popAndPushByNamed(BuildContext context,
//      String routeName) {
//    return Navigator.of(context).popAndPushNamed(routeName);
//  }

  static Future<dynamic> popAndPushByWidget(BuildContext context, Widget widget) {
    return Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => widget));
  }

  ///关闭一个页面，或者关闭一个对话框
  ///result:传递给上一个界面的参数，
  static pop<T>(BuildContext context,{T result}){
    Navigator.of(context).pop(result);
  }

  ///跳转新界面移除下部所有界面
  ///参数：上下文，新界面name
  static popAllAndPushByNamed(context, routeName) {
    Navigator.pushNamedAndRemoveUntil(
        context, routeName, (Route<dynamic> route) => false);
  }


//  static Future pushNamedForResult(BuildContext context, String routeName) {
//    return Navigator.pushNamed(context, routeName);
//  }
//
//  static Future pushForResult(BuildContext context, widget) {
//    return Navigator.push(
//        context, MaterialPageRoute(builder: (context) => widget));
//  }
//
//
//  static pop<T>(BuildContext context, T result) {
//    Navigator.of(context).pop(result);
//  }






}