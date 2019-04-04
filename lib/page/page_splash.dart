import 'package:flutter/material.dart';
import 'package:Inke/config/app_config.dart';
import 'package:Inke/config/route_config.dart';
import 'package:Inke/util/route_util.dart';
import 'dart:async';
import 'package:Inke/util/shared_util.dart';
import 'package:Inke/config/shared_key.dart';
import 'package:shimmer/shimmer.dart';

class SplashPage extends StatelessWidget {
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
              padding: const EdgeInsets.only(top: 15.0),
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Color(AppColors.C_0099FD),
                child: Text(
                  'Inke',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void jump2Guide(context) {
    Future.delayed(const Duration(seconds: 3), () {
      bool isFirst = SharedUtil.getInstance().get(SharedKey.isFirst, true);
      if (isFirst) {
        RouteUtil.popAndPushByNamed(context, RouteConfig.guideName);
      } else {
        RouteUtil.popAndPushByNamed(context, RouteConfig.mainName);
      }
    });
  }
}
