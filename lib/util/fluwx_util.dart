//import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:Inke/util/image_util.dart';

class FluWxUtil {
  ///初始化
  static initFluwx() async {
//    await fluwx.registerWxApi(
//        appId: 'wx1be424701c80ec69',
//        doOnAndroid: true,
//        doOnIOS: true,
//        );
  }

  ///分享至朋友
  static share(String url, String title, bool isFriend,
      {String description = "这是一条分享"}) {
    ///会话或者朋友圈
    //fluwx.WeChatScene scene = isFriend ? fluwx.WeChatScene.SESSION : fluwx.WeChatScene.TIMELINE;
    ///true为到朋友，false为朋友圈
//    fluwx.shareToWeChat(fluwx.WeChatShareWebPageModel(
//        url,
//        description: description,
//        title: title,
//        scene: scene,
//        thumbnail: fluwx.WeChatImage.asset(getImgPath('logo'))
//    ));
  }
}
