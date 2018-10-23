import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil{

  static showShortToast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        bgcolor: "#808080",
        textcolor: '#ffffff'
    );
  }

  static showLongToast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2,
        bgcolor: "#808080",
        textcolor: '#ffffff'

    );
  }
}