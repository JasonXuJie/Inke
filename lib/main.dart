import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config/AppConfig.dart';
import 'page/Login.dart';
import 'page/MainPage.dart';
import 'module_city/CityPage.dart';
import 'page/Guide.dart';
import 'page/Splash.dart';
import 'util/SharedUtil.dart';
import 'page/FeedBack.dart';
import 'module_my/Setting.dart';
import 'module_movie/MoreHotMovies.dart';
import 'module_movie/MoreMovies.dart';
import 'page/Search.dart';
import 'module_today_in_history/TodayInHistory.dart';
import 'module_my/Constellation.dart';
import 'module_movie/MoviesNewBoxOffice.dart';
import 'module_dream/Dream.dart';
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
          '/Guide':(BuildContext context)=> GuidePage(),
          '/Login':(BuildContext context)=> LoginPage(),
          '/Main':(BuildContext context)=>  MainPage(),
          '/City':(BuildContext context)=> CityPage(),
          '/FeedBack':(BuildContext context)=>FeedBackPage(),
          '/Setting':(BuildContext context)=>SettingPage(),
          '/MoreMovies':(context)=>MoreMoviesPage(),
          '/Search':(context)=>SearchPage(),
          '/Today':(context)=>TodayInHistoryPage(),
          '/Constellation':(context)=>ConstellationPage(),
          '/MoreHotMovies':(context)=>MoreHotMoviesPage(),
          '/MoviesNewBo':(context)=>MoviesNewBoPage(),
          '/Dream':(context)=>DreamPage(),
       } ,
    );
  }
}







































