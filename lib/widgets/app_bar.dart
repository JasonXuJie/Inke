import 'package:flutter/material.dart';
import 'package:Inke/widgets/text.dart';


class TopBar{

  static AppBar centerTitle(String title,{List<Widget> actions}){
    return AppBar(
      title: Text(title,style: TextStyles.whiteNormal14),
      centerTitle: true,
      actions: actions,
    );
  }
}