import 'package:flutter/material.dart';
import 'package:fluttie/fluttie.dart';
import 'package:Inke/util/toast.dart';


class AdvertView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<AdvertView> {

  FluttieAnimationController controller;

  @override
  void initState() {
    super.initState();
    prepare();
  }

  void prepare() async {
    final instance = Fluttie();
    final lottie = await instance.loadAnimationFromAsset('assets/json/banner.json');
    controller = await instance.prepareAnimation(lottie,
        repeatCount: RepeatCount.infinite());
    setState(() {
      controller.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
      child: GestureDetector(
        onTap: () => Toast.show('活动已结束！明年再来吧～～～'),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 150.0,
            child: FluttieAnimation(controller)),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}