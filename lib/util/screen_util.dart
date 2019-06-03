import 'package:flutter/material.dart';


class ScreenUtil{

  static double getSafeBottomPadding(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  static double getSafeTopPadding(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double getDeviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getDeviceHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }
}