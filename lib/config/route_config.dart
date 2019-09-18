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
import 'package:Inke/page/page_two_floor.dart';
import 'package:flutter/cupertino.dart';

///Route Path
class RouteConfig {
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
  static const String moreHotMoviesName = '/MoreHotMovies';
  static const String registerName = '/Register';
  static const String stillName = '/Still';
  static const String themeName = '/Theme';
  static const String webName = '/Web';
  static const String stepName = '/Stepper';
  static const String twoFloorName = '/TwoFloor';
}

class Router {
  //自定义路由信息(带参数，用名字跳转)
  static Map<String, Function> paramRoutes = {
    RouteConfig.stillName: (context, {arguments}) =>
        PhotoPage(arguments: arguments),
    RouteConfig.webName: (context, {arguments}) => WebPage(arguments: arguments)
  };

  static Map<String, WidgetBuilder> routes = {
    RouteConfig.splashName: (context) => SplashPage(),
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
    RouteConfig.stepName: (context) => AppStepperPage(),
    RouteConfig.twoFloorName: (context) => TwoFloorPage()
  };

  static Route<dynamic> unknownRoute(RouteSettings settings) {
    String name = settings.name;
    print("onUnknownRoute:$name");
    return MaterialPageRoute(builder: (context) => NotFoundPage());
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String name = settings.name;
    final Function pageContentBuilder = paramRoutes[name];
    if (pageContentBuilder != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    }
  }
}

///路由工具类封装
class RouteUtil {
  ///跳转新界面
  ///参数：上下文，新界面Name
  static Future<dynamic> pushNamed(BuildContext context, String routeName) {
    return Navigator.pushNamed(context, routeName);
  }

  ///跳转新界面
  ///参数：上下文，指定widget界面
  static Future<dynamic> pushWidget(BuildContext context, Widget widget) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => widget));
  }

  ///跳转新界面并将自己移除(可以获取新界面的返回值)
  ///pushReplacementNamed，popAndPushNamed，pushReplacement
  static Future<dynamic> pushReplacementNamed(
      BuildContext context, String routeName) {
    return Navigator.of(context).pushReplacementNamed(routeName);
  }

  ///返回会有黑影
  static Future<dynamic> popAndPushNamed(
      BuildContext context, String routeName) {
    return Navigator.of(context).popAndPushNamed(routeName);
  }

  static Future<dynamic> pushReplacement(BuildContext context, Widget widget) {
    return Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => widget));
  }

  ///关闭一个页面，或者关闭一个对话框
  ///result:传递给上一个界面的参数，
  static pop<T>(BuildContext context, {T result}) {
    Navigator.of(context).pop(result);
  }

  ///跳转新界面移除下部所有界面
  ///参数：上下文，新界面name
  static Future<dynamic> pushNamedAndRemoveUntil(
      BuildContext context, String routeName) {
    return Navigator.pushNamedAndRemoveUntil(
        context, routeName, (Route<dynamic> route) => false);
  }

  ///IOS路由滑动页面切换效果
  static Future<dynamic> pushIos(BuildContext context, Widget page) {
    return Navigator.push(
        context, CupertinoPageRoute(builder: (context) => page));
  }

  ///跳转名字带参数
  static Future<dynamic> pushNamedByArgs(
      BuildContext context, String routeName, Object args) {
    return Navigator.pushNamed(context, routeName, arguments: args);
  }

  ///页面逐渐放大展开
  static pushScale(BuildContext context, Widget page) {
    Navigator.push(context, PageRouteBuilder(pageBuilder: (BuildContext context,
        Animation animation, Animation secondaryAnimation) {
      return ScaleTransition(
          scale: animation, alignment: Alignment.center, child: page);
    }));
  }

  ///淡出效果
  static pushFade(BuildContext context, Widget page) {
    Navigator.push(context, PageRouteBuilder(pageBuilder: (BuildContext context,
        Animation animation, Animation secondaryAnimation) {
      return FadeTransition(opacity: animation, child: page);
    }));
  }

  ///旋转效果
  static jump3(BuildContext context, Widget page) {
    Navigator.push(context, PageRouteBuilder(pageBuilder: (BuildContext context,
        Animation animation, Animation secondaryAnimation) {
      return RotationTransition(
          alignment: Alignment.center, turns: animation, child: page);
    }));
  }

  ///出现方向
  static pushSlide(BuildContext context, Widget page) {
    Navigator.push(context, PageRouteBuilder(pageBuilder: (BuildContext context,
        Animation animation, Animation secondaryAnimation) {
      return SlideTransition(position: animation, child: page);
    }));
  }
}
