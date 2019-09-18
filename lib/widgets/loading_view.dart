import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:fluttie/fluttie.dart';

///加载控件
class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS
          ? CupertinoActivityIndicator()
          : CircularProgressIndicator(),
    );
  }
}

///Lottie加载
class LoadingAnimView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoadingState();
}

class _LoadingState extends State<LoadingAnimView> {
  FluttieAnimationController controller;

  @override
  void initState() {
    super.initState();
    prepare();
  }

  void prepare() async {
    final instance = Fluttie();
    final lottie = await instance.loadAnimationFromAsset('images/loading.json');
    controller = await instance.prepareAnimation(lottie,
        repeatCount: RepeatCount.infinite());
    setState(() {
      controller.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 130,
        height: 130,
        child: FluttieAnimation(controller),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
