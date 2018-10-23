import 'package:flutter/material.dart';

class LoadingView extends Dialog{

  String text;

  LoadingView({Key key,@required this.text}):super(key:key);


  @override
  Widget build(BuildContext context) {
    return Material(//创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
        child: SizedBox(
          width: 120.0,
          height: 120.0,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                   CircularProgressIndicator(),
                   Padding(
                       padding:EdgeInsets.only(top: 20.0),
                       child: Text(
                         text,
                         style: TextStyle(fontSize: 13.0),
                       ),
                   )

              ],
            ),
          ),
        ),
      ),
    );
  }
}