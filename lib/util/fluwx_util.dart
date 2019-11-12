//import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:Inke/util/image_util.dart';

class FluWx {
  ///初始化
  static initFluwx() async {
//    await fluwx.registerWxApi(
//        appId: 'wx1be424701c80ec69',
//        doOnAndroid: true,
//        doOnIOS: true,
//        );
//    var result = await fluwx.isWeChatInstalled();
   // print("初始化$result");
  }

  ///分享至朋友
  static share(String url, String title, bool isFriend,
      {String description = "这是一条分享"}) {
//    fluwx.WeChatScene scene =
//        isFriend ? fluwx.WeChatScene.SESSION : fluwx.WeChatScene.TIMELINE;
//
//    ///true为到朋友，false为朋友圈
//    fluwx.share(fluwx.WeChatShareWebPageModel(
//        webPage: url,
//        title: title,
//        description: description,
//        scene: scene,
//        thumbnail: getImgPath('logo'),
//        transaction: "hh"));
  }
}
