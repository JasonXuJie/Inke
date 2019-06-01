import 'package:fluttertoast/fluttertoast.dart';
import 'package:Inke/config/app_config.dart';
import 'package:flutter/material.dart';

class ToastUtil {
  static showShortToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: AppColors.toastBackground,
      textColor: AppColors.white,
      fontSize: 16.0,
    );
  }

  static showLongToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 2,
      backgroundColor: AppColors.toastBackground,
      textColor: AppColors.white,
      fontSize: 16.0,
    );
  }

  static cancel() {
    Fluttertoast.cancel();
  }
}
