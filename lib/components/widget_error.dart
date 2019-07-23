import 'package:flutter/material.dart';


///Flutter报错后一般都是红色背景加黄色字体显示堆栈，
///为了良好的交互模型，可以选中此控件进行优化
class MyErrorWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return _buildError();
  }

  _buildError() {
    return ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
      print(flutterErrorDetails.toString());//出错具体内容
      return Scaffold(
        appBar: AppBar(
          title: Text('出错'),
          centerTitle: true,
        ),
        body: Center(
          child: Text('Flutter 走神了!'),
        ),
      );
    };
  }
}
