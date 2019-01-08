import 'package:flutter/material.dart';


//跳转工具类
class JumpUtil{

  ///跳转新界面
  ///参数：上下文，新界面name
  static pushNamed(context,routeName){
    Navigator.pushNamed(context,routeName);
  }

  ///跳转新界面后关闭当前界面
  ///参数：上下文，新界面name
  static pushNameAndRemove(context,routeName){
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route)=>route==null);
  }

  ///跳转新界面
  ///参数：上下文，指定widget界面
  static push(BuildContext context,widget){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
  }

   static Future pushNamedForResult(BuildContext context,String routeName){
    return Navigator.pushNamed(context, routeName);
  }

}