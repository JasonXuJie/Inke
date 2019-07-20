import 'package:flutter/material.dart';


///在无法获取BuildContext的地方能获取到context
class NavigateService{

  final GlobalKey<NavigatorState> key = GlobalKey(debugLabel: "navigate_key");

  NavigatorState get navigator => key.currentState;

  get pushNamed => navigator.pushNamed;

  get push => navigator.push;
}