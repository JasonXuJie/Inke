import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

///加载控件
class LoadingView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS?CupertinoActivityIndicator():CircularProgressIndicator(),
    );
  }

}