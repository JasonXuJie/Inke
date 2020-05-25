import 'package:Inke/config/shared_key.dart';
import 'package:flutter/material.dart';
import 'package:Inke/config/colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:Inke/widgets/widget_icon.dart';
import 'package:Inke/widgets/text.dart';
import 'package:Inke/router/navigator_util.dart';
import 'package:Inke/router/routes.dart';
import 'package:flustars/flustars.dart';

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
                if(SpUtil.getBool(SharedKey.isFirst,defValue: true)){
                  NavigatorUtil.pushAndReplace(context, Routes.guide);
                }else{
                  NavigatorUtil.pushAndReplace(context, Routes.main);
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
                  style: TextStyles.whiteBold14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
