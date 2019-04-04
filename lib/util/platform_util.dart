import 'dart:io';

class PlatformUtil{

  static bool isIOS(){
    return Platform.isIOS;
  }

  static bool isAndroid(){
    return Platform.isAndroid;
  }

  static bool isFuchsia(){
    return Platform.isFuchsia;
  }

}