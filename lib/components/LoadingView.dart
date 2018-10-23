import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
class LoadingView extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS?CupertinoActivityIndicator():CircularProgressIndicator(),
    );
  }

}