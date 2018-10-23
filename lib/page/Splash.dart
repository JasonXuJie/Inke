import 'dart:async';
import 'package:flutter/material.dart';
import '../config/AppConfig.dart';

class SplashPage extends StatelessWidget {


  void jump2Login(context) {
    new Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(context, '/Guide', (route)=>route==null);
    });
  }

  @override
  Widget build(BuildContext context) {
    jump2Login(context);
    return Container(
      color: Color(AppColors.colorPrimary),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImgPath.mainPath+'app_icon.png',
              width: 150.0,
              height: 150.0,
            ),
            Text(
              'Inke',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
