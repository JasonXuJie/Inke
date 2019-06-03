import 'package:device_info/device_info.dart';

///获取设备信息工具类
class DeviceUtil {

  ///获取安卓设备信息对象
  static Future<AndroidDeviceInfo> androidDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo;
  }

  ///获取IOS设备信息对象
  static Future<IosDeviceInfo> iosDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo;
  }
}
