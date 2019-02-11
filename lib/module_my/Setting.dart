import 'package:flutter/material.dart';
import '../config/AppConfig.dart';
import '../components/LogoutDialog.dart';


class SettingPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('设置'),
         centerTitle: true,
       ),
       body: Padding(
           padding: const EdgeInsets.only(top: 30.0,left: 15.0,right: 15.0),
           child: ListTile(
             title: Text('退出登陆'),
             leading: Icon(Icons.all_out,size: 20.0,),
             trailing:  Image.asset(
               AppImgPath.mainPath + 'img_right_arrow.png',
               width: 10.0,
               height: 10.0,
             ),
             onTap: (){
               _showDialog(context);
             },
           ),
       )
     );
  }

  _showDialog(BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context){
          return LogoutDialog();
        }
    );
  }
}