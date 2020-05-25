import 'package:Inke/provider/provider_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Inke/config/colors.dart';
import 'package:provider/provider.dart';
import 'package:Inke/util/service_locator.dart';
import 'package:oktoast/oktoast.dart';
import 'package:Inke/util/fluwx_util.dart';
import 'package:Inke/widgets/refresh_helper.dart';
import 'package:Inke/router/routes.dart';
import 'package:Inke/router/application.dart';
import 'package:Inke/modules/page_splash.dart';
import 'package:flustars/flustars.dart';
import 'package:Inke/http/http_client.dart';
import 'package:Inke/http/http_client_jh.dart';
import 'package:Inke/http/http_client_afd.dart';
import 'package:Inke/http/api.dart';

import 'package:Inke/test/provider_test.dart';
import 'package:Inke/test/counter.dart';


void main() async {
  ///由于在main方法上添加了async需要添加此行代码进行绑定初始化，没有future则不需要添加次行代码
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  setupLocator();
  await SpUtil.getInstance();
  ///初始化微信分享Sdk
  FluWxUtil.initFluwx();
  runApp(InkeApp());
}

class InkeApp extends StatelessWidget {

  InkeApp(){
    ///路由注册
    Routes.register();
    ///网络请求初始化
    HttpClient().init(baseUrl: Api.doubanBaseUrl,receiveTimeout: 60000,connectTimeOut: 60000);
    HttpClientJh().init(baseUrl: Api.juheBaseUrl,receiveTimeout: 60000,connectTimeOut: 60000);
    HttpClientAfd().init(baseUrl: Api.afandaBaseUrl,receiveTimeout: 60000,connectTimeOut: 60000);
  }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers,
        child: OKToast(
            dismissOtherOnShow: true,
            backgroundColor: Colors.black54,
            position: ToastPosition.bottom,
            radius: 20.0,
            textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: RefreshConfig(
              child: MaterialApp(
                  navigatorKey: getIt<NavigateService>().key,
                  debugShowCheckedModeBanner: false,
                  title: 'Inke',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                    primaryColor: AppColors.colorPrimary,
                    scaffoldBackgroundColor: AppColors.white, //默认全局背景色
                    appBarTheme: AppBarTheme(color: Colors.blue)
                  ),
                  onGenerateRoute: Application.router.generator,
                  home: SplashPage(),
                  //home: ProviderPage(),
              ),
            )
        )
    );
  }
}
