import 'package:flutter/material.dart';
import 'package:Inke/widgets/dialog_logout.dart';
import 'package:Inke/config/route_config.dart';
import 'package:Inke/util/route_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:Inke/provider/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:Inke/widgets/gaps.dart';
import 'package:Inke/widgets/dialog_author.dart';
import 'package:Inke/util/image_util.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingPage> {
  @protected
  bool isCheck = false;

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
          child: Column(
            children: <Widget>[
              _buildItem('更换主题', () {
                RouteUtil.pushByNamed(context, RouteConfig.themeName);
              }),
              Gaps.vGap10,
              _buildItem('开启缓存', null, trailing: CupertinoSwitch(
                  value: isCheck, onChanged: (isCheck) {
                setState(() {
                  this.isCheck = isCheck;
                });
              })),
              Gaps.vGap10,
              _buildItem('联系作者', () {
                _showAuthorDialog();
              }),
              Gaps.hGap15,
              RaisedButton(
                  color: Colors.red,
                  child: Container(
                    width: 200.0,
                    child: Center(
                      child: Text(
                        '退出登陆', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  onPressed: () {
                    _showLogoutDialog();
                  })
            ],
          ),
        ));
  }

  Widget _buildItem(String title, Function onTap, {Widget trailing}) {
    return ListTile(
      title: Text(title),
      leading: Icon(
        Icons.all_out,
        size: 20.0,
      ),
      trailing: trailing == null
          ?loadAssetImage('img_right_arrow',width: 10.0,height: 10.0) : trailing,
      onTap: onTap,
    );
  }

  _showLogoutDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return LogoutDialog(() {
            Provider.of<LoginProvider>(context).hasLogin(false);
            RouteUtil.popAllAndPushByNamed(context, RouteConfig.mainName);
          });
        });
  }

  _showAuthorDialog() {
    showDialog(context: context,
        barrierDismissible: true,
        builder: (context) {
          return AuthorDialog();
        }
    );
  }
}
