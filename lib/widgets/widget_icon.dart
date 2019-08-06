import 'package:flutter/material.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/config/app_config.dart';


typedef void OnAnimEndCallBack();

class IconWidget extends StatefulWidget{

  final OnAnimEndCallBack callBack;

  IconWidget({Key key,@required this.callBack}):super(key:key);

  @override
  State<StatefulWidget> createState() => _State();
}


class _State extends State<IconWidget> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Animation animation;




  @override
  void initState(){
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(seconds: 3));
    animation = Tween(begin: 0.0,end: 1.0).animate(_controller)
      ..addStatusListener((state){
        if(state == AnimationStatus.completed){
           widget.callBack();
        }
      });
    _controller.forward();
  }



  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns:animation,
      child: loadAssetImage('app_icon',width: 100.0,height: 100.0)
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
