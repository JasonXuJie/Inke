import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:Inke/modules/page_guide.dart';
import 'package:Inke/modules/login/page_login.dart';
import 'package:Inke/modules/login/page_register.dart';
import 'package:Inke/modules/page_main.dart';
import 'package:Inke/modules/city/page_city.dart';
import 'package:Inke/modules/page_search.dart';
import 'package:Inke/modules/web/page_web.dart';
import 'package:Inke/modules/my/page_feed_back.dart';
import 'package:Inke/modules/my/page_history_list.dart';
import 'package:Inke/modules/my/page_history_details.dart';
import 'package:Inke/modules/my/page_my_setting.dart';
import 'package:Inke/modules/my/page_pairing.dart';
import 'package:Inke/modules/my/page_setting.dart';
import 'package:Inke/modules/my/page_theme.dart';
import 'package:Inke/modules/my/page_dream.dart';
import 'package:Inke/modules/movie/page_two_floor.dart';
import 'package:Inke/modules/movie/page_photo_details.dart';
import 'package:Inke/modules/movie/page_movie_details.dart';
import 'package:Inke/router/fluro_convert_util.dart';
import 'package:flustars/flustars.dart';

///引导页
var guideHandler = Handler(handlerFunc:(BuildContext context,Map<String,List<String>> params){
   return GuidePage();
});


///登陆页
var loginHandler = Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params){
  return LoginPage();
});


///注册页
var registerHandler = Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params){
  return RegisterPage();
});

///主页
var mainHandler = Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params){
  return MainPage();
});

///城市列表
var cityListHandler = Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params){
  return CityPage();
});

///搜索页
var searchHandler = Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params){
  return SearchPage();
});

///网页容器(传参)
var webHandler = Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params){
  String title = params['title'].first;
  String url = params['url'].first;
  return WebPage(title: title,url: url);
});

///我的模块
///反馈模块
var feedBackHandler = Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params){
   return FeedBackPage();
});
///历史今天列表
var historyListHandler = Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params){
  return HistoryListPage();
});
///历史今天详情(传参)
var historyDetailHandler = Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params){
   String eId = params['eId'].first;
   String title = params['title'].first;
   return HistoryDetailsPage(e_id: eId, title: title) ;
});
///我的设置(传参)
var mySettingHandler = Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params){
   String name = params['name'].first;
   return MyInfoSettingPage(name: name);
});
///配对页面(传参)
var pairHandler = Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params){
    bool flag = FluroConvertUtil.str2bool(params['flag'].first);
    return PairingPage(flag: flag);
});
///设置
var settingHandler = Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params){
   return SettingPage();
});
///主题页面
var themeHandler = Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params){
  return ThemePage();
});
///周公解梦页面
var dreamHandler = Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params){
    return DreamPage();
});

///电影模块
///二楼页面
var twoFloorHandler = Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params){
  return TwoFloorPage();
});
///剧照页面(传参)
var photoHandler = Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params){
  String id = params['id'].first;
  String count = params['count'].first;
  return PhotoPage(id: id,count: count);
});
///电影详情页面(传参)
var movieDetailHandler = Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params){
  String id = params['id'].first;
  String title = params['title'].first;
  String image = params['image'].first;
  List<String> heroTagList = params['heroTag'];
  if(ObjectUtil.isEmptyList(heroTagList)){
    return MovieDetailsPage(id: id,title: title,image: image,heroTag: null);
  }else{
    return MovieDetailsPage(id: id,title: title,image: image,heroTag: heroTagList.first);
  }

});
