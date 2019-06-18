import 'package:Inke/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Inke/config/app_config.dart';
import 'package:Inke/config/route_config.dart';
import 'package:Inke/module_login/page_login.dart';
import 'package:Inke/util/shared_util.dart';
import 'package:Inke/module_my/page_feed_back.dart';
import 'package:Inke/module_my/page_setting.dart';
import 'package:Inke/module_movie/page_more_hot_movies.dart';
import 'package:Inke/module_movie/page_more_movies.dart';
import 'package:Inke/page/page_search.dart';
import 'package:Inke/module_my/page_today_in_history.dart';
import 'package:Inke/module_my/page_dream.dart';
import 'package:Inke/page/page_splash.dart';
import 'package:Inke/page/page_guide.dart';
import 'package:Inke/page/page_not_found.dart';
import 'package:Inke/page/page_main.dart';
import 'package:Inke/page/page_city.dart';
import 'package:Inke/module_login/page_register.dart';
import 'package:Inke/module_movie/page_photo_details.dart';
import 'package:Inke/page/page_theme.dart';
import 'package:provider/provider.dart';
import 'package:Inke/provider/city_provider.dart';
import 'package:Inke/provider/first_provider.dart';
import 'package:Inke/provider/date_type_provider.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await SharedUtil.getInstance().init();
  runApp(InkeApp());
}


class InkeApp extends StatelessWidget {

//  final store = Store<GlobalState>(appReducer,
//      initialState: GlobalState(
//        user: User.empty(),
//        city: City(
//            name: SharedUtil.getInstance().get(SharedKey.cityName, '上海'),
//            cityId: SharedUtil.getInstance().get(SharedKey.cityId, '108296')),
//        isLogin: SharedUtil.getInstance().get(SharedKey.isLogin, false),
//        isFirst: SharedUtil.getInstance().get(SharedKey.isFirst, true),
//        dateType: 'future',
//      ));

  //自定义路由信息
  final Map<String, Function> routes = {
    RouteConfig.stillName: (context, {arguments}) => PhotoPage(
          arguments: arguments,
        )
  };


  @override
  Widget build(BuildContext context) {
    var firstProvider = FirstProvider();
    var cityProvider = CityProvider();
    var loginProvider = LoginProvider();
    var dateTypeProvider = DateTypeProvider();
    return MultiProvider(
      providers: [
        Provider<CityProvider>.value(value: cityProvider),
        Provider<FirstProvider>.value(value: firstProvider),
        Provider<LoginProvider>.value(value: loginProvider),
        Provider<DateTypeProvider>.value(value: dateTypeProvider),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inke',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: AppColors.colorPrimary,
          scaffoldBackgroundColor: AppColors.windowBackground, //默认全局背景色
        ),
        home: SplashPage(),
        routes: <String, WidgetBuilder>{
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
          RouteConfig.themeName:(context) => ThemePage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          final String name = settings.name;
          final Function pageContentBuilder = this.routes[name];
          if (pageContentBuilder != null) {
            final Route route = MaterialPageRoute(
                builder: (context) =>
                    pageContentBuilder(context, arguments: settings.arguments));
            return route;
          }
        },
        onUnknownRoute: (RouteSettings setting) {
          String name = setting.name;
          print("onUnknownRoute:$name");
          return MaterialPageRoute(builder: (context) => NotFoundPage());
        },
      ),
    );
  }
}
