import 'package:connectivity/connectivity.dart';

///获取设备连接状态
class ConnectUtil {
  ///是
  static Future<bool> isMobile() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    bool isMobile =
        connectivityResult == ConnectivityResult.mobile ? true : false;
    return isMobile;
  }

  static Future<bool> isWifi() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    bool isWifi = connectivityResult == ConnectivityResult.wifi ? true : false;
    return isWifi;
  }

  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    bool isConnected =
        connectivityResult != ConnectivityResult.none ? true : false;
    return isConnected;
  }
}
