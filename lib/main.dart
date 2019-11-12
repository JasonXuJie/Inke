import 'package:Inke/provider/provider_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Inke/config/colors.dart';
import 'package:Inke/config/route_config.dart';
import 'package:Inke/util/shared_util.dart';
import 'package:provider/provider.dart';
import 'package:Inke/util/service_locator.dart';
import 'package:oktoast/oktoast.dart';
import 'package:Inke/util/fluwx_util.dart';
import 'package:Inke/widgets/refresh_helper.dart';


void main() async {
  Provider.debugCheckInvalidValueType = null;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  setupLocator();
  await SharedUtil.getInstance().init();
  ///初始化微信分享Sdk
  FluWx.initFluwx();
  runApp(InkeApp());
}

class InkeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers,
        child: OKToast(
            dismissOtherOnShow: true,
            backgroundColor: Colors.black54,
            position: ToastPosition.bottom,
            radius: 20.0,
            textPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: RefreshConfig(
              child: MaterialApp(
                  navigatorKey: getIt<NavigateService>().key,
                  debugShowCheckedModeBanner: false,
                  title: 'Inke',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                    primaryColor: AppColors.colorPrimary,
                    scaffoldBackgroundColor:
                        AppColors.white, //默认全局背景色
                  ),
                  routes: Router.routes,
                  onGenerateRoute: Router.generateRoute,
                  initialRoute: RouteName.splashName,
                  onUnknownRoute: Router.unknownRoute),
            )));
  }
}
