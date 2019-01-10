import 'package:flutter/material.dart';
import '../config/AppConfig.dart';
import '../config/RouteConfig.dart';
import '../util/JumpUtil.dart';
import 'dart:async';
import '../util/SharedUtil.dart';
import '../config/SharedKey.dart';

class SplashPage extends StatelessWidget {


  void jump2Guide(context) {
    new Future.delayed(const Duration(seconds: 3), () {
      bool isFirst = SharedUtil.getInstance().get(SharedKey.IS_FIRST_LOGIN, true);
      if(isFirst){
        JumpUtil.pushNameAndRemove(context, RouteConfig.GUIDE_PATH);
      }else{
        JumpUtil.pushNameAndRemove(context, RouteConfig.MAIN_PATH);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    jump2Guide(context);
    return Container(
      color: Color(AppColors.colorPrimary),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImgPath.mainPath + 'app_icon.png',
              width: 100.0,
              height: 100.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Text(
                'Inke',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
