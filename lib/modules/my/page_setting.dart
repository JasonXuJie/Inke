import 'package:flutter/material.dart';
import 'package:Inke/modules/my/dialog_logout.dart';
import 'package:flutter/cupertino.dart';
import 'package:Inke/provider/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:Inke/widgets/gaps.dart';
import 'package:Inke/router/routes.dart';
import 'package:Inke/router/navigator_util.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingPage> {
  @protected
  bool isCheck = false;

  ///字体
  final fonts = ['跟随系统', '其它字体'];
  var _fontspos = 0;

  ///语言
  final language = ['跟随系统', '中文', '英语'];
  var _lanpos = 0;

  ///黑夜模式
  var isDark = false;

  @override
  Widget build(BuildContext context) {
    var iconColor = Theme.of(context).accentColor;
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: <Widget>[
              Gaps.vGap10,
              Material(
                color: Theme.of(context).cardColor,
                child: ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('字体'),
                      Text('跟随系统'),
                    ],
                  ),
                  leading: Icon(Icons.font_download, color: iconColor),
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: fonts.length,
                      itemBuilder: (BuildContext context, int pos) {
                        return RadioListTile(
                          value: pos,
                          onChanged: (int pos) {
                            setState(() {
                              _fontspos = pos;
                            });
                          },
                          groupValue: _fontspos,
                          title: Text(fonts[pos]),
                        );
                      },
                    )
                  ],
                ),
              ),
              Gaps.vGap10,
              Material(
                color: Theme.of(context).cardColor,
                child: ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('多语言'),
                      Text('跟随系统'),
                    ],
                  ),
                  leading: Icon(
                    Icons.language,
                    color: iconColor,
                  ),
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: language.length,
                      itemBuilder: (BuildContext context, int pos) {
                        return RadioListTile(
                          value: pos,
                          onChanged: (int pos) {
                            setState(() {
                              _lanpos = pos;
                            });
                          },
                          groupValue: _lanpos,
                          title: Text(language[pos]),
                        );
                      },
                    )
                  ],
                ),
              ),
              Gaps.vGap10,
              themeSetting(),
              Gaps.vGap10,
              Material(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  title: Text('开启缓存'),
                  leading: Icon(
                    Icons.cached,
                    color: iconColor,
                  ),
                  trailing: CupertinoSwitch(
                    value: isCheck,
                    onChanged: (bool isChecked) {
                      setState(() {
                        isCheck = isChecked;
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      isCheck = !isCheck;
                    });
                  },
                ),
              ),
              Gaps.vGap10,
              Material(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  title: Text('黑夜模式'),
                  leading: Icon(Icons.brightness_3,color: iconColor,),
                  trailing: CupertinoSwitch(
                    value: isDark,
                    onChanged: (bool isChecked) {
                      setState(() {
                        isDark = isChecked;
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      isDark = !isDark;
                    });
                  },
                ),
              ),
              Gaps.vGap15,
              RaisedButton(
                  color: Colors.red,
                  child: Container(
                    width: 200.0,
                    child: Center(
                      child: Text(
                        '退出登陆',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  onPressed: () {
                    _showLogoutDialog();
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget themeSetting() {
    return Material(
      color: Theme.of(context).cardColor,
      child: ExpansionTile(
        title: Text('主题'),
        leading: Icon(
          Icons.color_lens,
          color: Theme.of(context).accentColor,
        ),
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: <Widget>[
                ...Colors.primaries.map((color) {
                  return Material(
                    color: color,
                    child: InkWell(
                      onTap: () {
                        var brightness = Theme.of(context).brightness;
                        print(brightness);
                      },
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                      ),
                    ),
                  );
                }).toList(),
                Material(
                  child: InkWell(
                    onTap: () {
                      var brightness = Theme.of(context).brightness;
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).accentColor)),
                      width: 40,
                      height: 40,
                      child: Text(
                        '?',
                        style: TextStyle(
                            fontSize: 20, color: Theme.of(context).accentColor),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _showLogoutDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return LogoutDialog(() {
            Provider.of<LoginProvider>(context).hasLogin(false);
            NavigatorUtil.pushAndRemoveAll(context, Routes.main);
          });
        });
  }
}
