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
import 'page/NotFound.dart';
void main(){
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  SharedUtil.getInstance().init();
  runApp(InkeApp());
}


class InkeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inke',
      theme: new ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
        primaryColor: Color(AppColors.colorPrimary),
        backgroundColor: Color(AppColors.windowBackground),
      ),
       home:new SplashPage(),
       routes:<String,WidgetBuilder>{
         RouteConfig.SPLASH_PATH:(context)=>SplashPage(),
         RouteConfig.GUIDE_PATH:(context)=> GuidePage(),
         RouteConfig.LOGIN_PATH:(context)=> LoginPage(),
         RouteConfig.MAIN_PATH:(context)=>  MainPage(),
         RouteConfig.CITY_PATH:(context)=> CityPage(),
         RouteConfig.FEEDBACK_PATH:(context)=>FeedBackPage(),
         RouteConfig.SETTING_PATH:(context)=>SettingPage(),
          '/MoreMovies':(context)=>MoreMoviesPage(),
          RouteConfig.SEARCH_PATH:(context)=>SearchPage(),
          RouteConfig.TODAY_PATH:(context)=>TodayInHistoryPage(),
          RouteConfig.LUCK_PATH:(context)=>LuckPage(),
          '/MoreHotMovies':(context)=>MoreHotMoviesPage(),
          RouteConfig.MOVIE_RANKING_PATH:(context)=>MoviesNewBoPage(),
          RouteConfig.DREAM_PATH:(context)=>DreamPage(),
       } ,
       onUnknownRoute: (RouteSettings setting){
         String name = setting.name;
         print("onUnknownRoute:$name");
         return MaterialPageRoute(builder: (context)=>NotFoundPage());
       },
    );
  }
}







































