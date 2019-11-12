import 'package:flutter/material.dart';
import 'package:Inke/config/colors.dart';
import 'package:Inke/config/route_config.dart';
import 'package:shimmer/shimmer.dart';
import 'package:Inke/widgets/widget_icon.dart';
import 'package:provider/provider.dart';
import 'package:Inke/provider/first_provider.dart';
import 'package:Inke/widgets/text.dart';

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
                  RouteUtil.pushReplacementNamed(context, RouteName.guideName);
                } else {
                  RouteUtil.pushReplacementNamed(context, RouteName.mainName);
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
