import 'package:Inke/util/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static void launchTelUrl(String phone) async {
    String url = 'tel:' + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show('拨号失败');
    }
  }

  static void launchWebUrl() async {
    String url = 'https://github.com/JasonXuJie';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show('访问失败');
    }
  }
}
