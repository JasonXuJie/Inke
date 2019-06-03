import 'package:flutter/material.dart';

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
