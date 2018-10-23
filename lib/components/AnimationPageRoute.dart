import 'package:flutter/material.dart';


class AnimationPageRoute<T> extends MaterialPageRoute<T>{
  Tween<Offset> slideTween;
  Tween<double> fadeTween;


  AnimationPageRoute({WidgetBuilder builder,RouteSettings settings,
  bool maintainState:true,bool fullscreenDialog:true,this.slideTween,this.fadeTween}):super(builder:builder,settings:settings
  ,fullscreenDialog:fullscreenDialog);


  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    Widget widget = SlideTransition(
        position: _getSlideAnimation(animation),
    child: FadeTransition(opacity: _getFadeAnimation(animation),child: child,));
    return widget;
  }


  Animation<Offset> _getSlideAnimation(Animation<double> animation){
    if(slideTween == null){
      slideTween = Tween<Offset>(
        begin: Offset(0.0, 0.0),
        end: Offset.zero,
      );
    }
    return slideTween.animate(CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn));
  }

  Animation<double> _getFadeAnimation(Animation<double> animation){
    if(fadeTween == null){
      fadeTween = Tween<double>(
        begin: 1.0,
        end: 1.0,
      );
    }
    return fadeTween.animate(CurvedAnimation(parent: animation, curve: Curves.easeIn));
  }
}