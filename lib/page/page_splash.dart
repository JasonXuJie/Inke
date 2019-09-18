import 'package:flutter/material.dart';
import 'package:Inke/config/app_config.dart';
import 'package:Inke/config/route_config.dart';
import 'dart:async';
import 'package:Inke/util/shared_util.dart';
import 'package:Inke/config/shared_key.dart';
import 'package:shimmer/shimmer.dart';
import 'package:Inke/widgets/widget_icon.dart';
import 'package:provider/provider.dart';
import 'package:Inke/provider/first_provider.dart';

class SplashPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.colorPrimary,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconWidget(
              callBack: () {
                bool isFirst = Provider.of<FirstProvider>(context).isFirst;
                if (isFirst) {
                  RouteUtil.pushReplacementNamed(context, RouteConfig.guideName);
                } else {
                  RouteUtil.pushReplacementNamed(context, RouteConfig.mainName);
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: AppColors.color_0099fd,
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
        RouteUtil.pushReplacementNamed(context, RouteConfig.guideName);
      } else {
        RouteUtil.pushReplacementNamed(context, RouteConfig.mainName);
      }
    });
  }
}
