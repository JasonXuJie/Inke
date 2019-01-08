import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config/AppConfig.dart';
import 'config/RouteConfig.dart';

import 'page/Guide.dart';
import 'module_login/Login.dart';
import 'page/Main.dart';
import 'page/City.dart';
import 'module_my/Luck.dart';

import 'page/Splash.dart';
import 'util/SharedUtil.dart';
import 'module_my/FeedBack.dart';
import 'module_my/Setting.dart';
import 'module_movie/MoreHotMovies.dart';
import 'module_movie/MoreMovies.dart';
import 'page/Search.dart';
import 'package:Inke/module_my/TodayInHistory.dart';
import 'module_movie/MoviesNewBoxOffice.dart';
import 'module_my/Dream.dart';
void main(){
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  SharedUtil.getInstance().init();
  runApp(new MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //配置APP主题
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inke',
      theme: new ThemeData(
        // This is the theme of your application.
       // primarySwatch: Color(AppColors.colorPrimary),
        primaryColor: Color(AppColors.colorPrimary),
        backgroundColor: Color(AppColors.windowBackground),
      ),
       home:new SplashPage(),
       routes:<String,WidgetBuilder>{
         RouteConfig.GUIDE_PATH:(BuildContext context)=> GuidePage(),
         RouteConfig.LOGIN_PATH:(BuildContext context)=> LoginPage(),
         RouteConfig.MAIN_PATH:(BuildContext context)=>  MainPage(),
         RouteConfig.CITY_PATH:(BuildContext context)=> CityPage(),
         RouteConfig.FEEDBACK_PATH:(BuildContext context)=>FeedBackPage(),
         RouteConfig.SETTING_PATH:(BuildContext context)=>SettingPage(),
          '/MoreMovies':(context)=>MoreMoviesPage(),
          RouteConfig.SEARCH_PATH:(context)=>SearchPage(),
          RouteConfig.TODAY_PATH:(context)=>TodayInHistoryPage(),
          RouteConfig.LUCK_PATH:(context)=>LuckPage(),
          '/MoreHotMovies':(context)=>MoreHotMoviesPage(),
          RouteConfig.MOVIE_RANKING_PATH:(context)=>MoviesNewBoPage(),
          RouteConfig.DREAM_PATH:(context)=>DreamPage(),
       } ,
    );
  }
}







































