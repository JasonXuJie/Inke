import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:Inke/router/application.dart';
import 'package:Inke/widgets/page_not_found.dart';
import 'package:Inke/router/route_handlers.dart';

class Routes{

  ///引导页
  static String guide = '/guide';

  ///登陆页
  static String login = '/login';

  ///注册页
  static String registered = '/registered';

  ///主页
  static String main = '/main';

  ///城市列表
  static String cityList = '/cityList';

  ///搜索页
  static String search = '/search';

  ///web容器
  static String web = '/web';

  ///反馈页
  static String feedBack = '/feedBack';

  ///历史上的今天列表页
  static String historyList = '/historyList';

  ///历史上的今天详情
  static String historyDetail = '/historyDetail';

  ///我的设置页面
  static String mySetting = '/mySetting';

  ///配对页
  static String pair = '/pair';

  ///设置页面
  static String setting = '/setting';

  ///主题页面
  static String theme = '/theme';

  ///周公解梦
  static String dream = '/dream';

  ///二楼页
  static String twoFloor = '/twoFloor';

  ///剧照页面
  static String photos = '/photos';

  ///电影详情页
  static String movieDetails = '/movieDetails';





  static void register(){
    final Router router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }



  static void configureRoutes(Router router){
    router.notFoundHandler = Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params){
        return NotFoundPage();
    });
    router.define(guide, handler: guideHandler);
    router.define(login, handler: loginHandler);
    router.define(registered, handler: registerHandler);
    router.define(main, handler: mainHandler);
    router.define(cityList, handler: cityListHandler);
    router.define(search, handler: searchHandler);
    router.define(web, handler: webHandler);
    router.define(feedBack, handler: feedBackHandler);
    router.define(historyList, handler: historyListHandler);
    router.define(historyDetail, handler: historyDetailHandler);
    router.define(mySetting, handler: mySettingHandler);
    router.define(pair, handler: pairHandler);
    router.define(setting, handler: settingHandler);
    router.define(theme, handler: themeHandler);
    router.define(dream, handler: dreamHandler);
    router.define(twoFloor, handler: twoFloorHandler);
    router.define(photos, handler: photoHandler);
    router.define(movieDetails, handler: movieDetailHandler);
  }
}