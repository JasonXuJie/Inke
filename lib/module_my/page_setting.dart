import 'package:flutter/material.dart';
import 'package:Inke/config/app_config.dart';
import 'package:Inke/components/dialog_logout.dart';
import 'package:Inke/util/shared_util.dart';
import 'package:Inke/config/shared_key.dart';
import 'package:Inke/config/route_config.dart';
import 'package:Inke/util/route_util.dart';
import 'package:Inke/redux/is_login_reducer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:Inke/redux/global_state.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('设置'),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          margin: const EdgeInsets.only(top: 15.0),
          child: ListTile(
            title: Text('退出登陆'),
            leading: Icon(
              Icons.all_out,
              size: 20.0,
            ),
            trailing: Image.asset(
              AppImgPath.mainPath + 'img_right_arrow.png',
              width: 10.0,
              height: 10.0,
            ),
            onTap: () {
              _showDialog(context);
            },
          ),
        ));
  }

  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return LogoutDialog((){
            SharedUtil.getInstance().put(SharedKey.isLogin, false);
            StoreProvider.of<GlobalState>(context).dispatch(UpdateIsLoginAction(false));
            RouteUtil.popAllAndPushByNamed(context,RouteConfig.mainName);
          });
        });
  }
}