
import 'package:Inke/page/page_splash.dart';
import 'package:flutter/material.dart';
import 'package:Inke/page/page_guide.dart';
import 'package:Inke/module_login/page_login.dart';
import 'package:Inke/page/page_main.dart';
import 'package:Inke/page/page_city.dart';
import 'package:Inke/module_my/page_feed_back.dart';
import 'package:Inke/module_my/page_setting.dart';
import 'package:Inke/module_movie/page_more_movies.dart';
import 'package:Inke/page/page_search.dart';
import 'package:Inke/module_my/page_today_in_history.dart';
import 'package:Inke/module_movie/page_more_hot_movies.dart';
import 'package:Inke/module_login/page_register.dart';
import 'package:Inke/module_my/page_dream.dart';
import 'package:Inke/page/page_theme.dart';
import 'package:Inke/page/page_not_found.dart';
import 'package:Inke/module_movie/page_photo_details.dart';
import 'package:Inke/page/page_web.dart';
import 'package:Inke/page/page_app_stepper.dart';

///Route Path
class RouteConfig{
  static const String splashName = 'Splash';
  static const String guideName = '/Guide';
  static const String loginName = '/Login';
  static const String mainName = '/Main';
  static const String searchName = '/Search';
  static const String cityName = '/City';
  static const String settingName = '/Setting';
  static const String feedBackName = '/FeedBack';
  static const String dreamName = '/Dream';
  static const String todayName = '/Today';
  static const String moreMoviesName = '/MoreMovies';
  static const String moreHotMoviesName =  '/MoreHotMovies';
  static const String registerName = '/Register';
  static const String stillName = '/Still';
  static const String themeName = '/Theme';
  static const String webName = '/Web';
  static const String stepName = '/Stepper';
}

class Router{

  //自定义路由信息(带参数，用名字跳转)
  static Map<String,Function> paramRoutes = {
    RouteConfig.stillName:(context,{arguments})=> PhotoPage(arguments: arguments),
    RouteConfig.webName:(context,{arguments})=> WebPage(arguments: arguments)
  };


  static Map<String,WidgetBuilder> routes = {
    RouteConfig.splashName:(context)=>SplashPage(),
    RouteConfig.guideName: (context) => GuidePage(),
              RouteConfig.loginName: (context) => LoginPage(),
              RouteConfig.mainName: (context) => MainPage(),
              RouteConfig.cityName: (context) => CityPage(),
              RouteConfig.feedBackName: (context) => FeedBackPage(),
              RouteConfig.settingName: (context) => SettingPage(),
              RouteConfig.moreMoviesName: (context) => MoreMoviesPage(),
              RouteConfig.searchName: (context) => SearchPage(),
              RouteConfig.todayName: (context) => TodayInHistoryPage(),
              RouteConfig.moreHotMoviesName: (context) => MoreHotMoviesPage(),
              RouteConfig.dreamName: (context) => DreamPage(),
              RouteConfig.registerName: (context) => RegisterPage(),
              RouteConfig.themeName: (context) => ThemePage(),
              RouteConfig.stepName:(context)=> AppStepperPage()
  };

  static Route<dynamic> unknownRoute(RouteSettings settings){
    String name = settings.name;
    print("onUnknownRoute:$name");
    return MaterialPageRoute(builder: (context)=>NotFoundPage());
  }

  static Route<dynamic> generateRoute(RouteSettings settings){
    final String name = settings.name;
    final Function pageContentBuilder = paramRoutes[name];
    if(pageContentBuilder!=null){
      final Route route = MaterialPageRoute(builder: (context)=>pageContentBuilder(context,arguments:settings.arguments));
      return route;
    }

  }
}