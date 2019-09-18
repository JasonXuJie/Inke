import 'package:flutter/material.dart';
import 'package:Inke/config/route_config.dart';
import 'package:Inke/module_my/page_my_setting.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'page_pairing.dart';
import 'package:Inke/util/shared_util.dart';
import 'package:Inke/config/shared_key.dart';
import 'package:Inke/widgets/bottom_photo_view.dart';
import 'package:provider/provider.dart';
import 'package:Inke/provider/login_provider.dart';
import 'package:Inke/widgets/bottom_clipper.dart';
import 'package:Inke/widgets/text.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/widgets/search_delegate.dart';

class MyIndex extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyIndex> with AutomaticKeepAliveClientMixin {
  var methodChannel = const MethodChannel('com.jason.myfluttertest/module_my');
  var webChannel = const MethodChannel('com.jason.myfluttertest/web');
  File _header;

  final menus = {
    '历史上的今天': 'menu_list_one',
    '周公解梦': 'menu_list_two',
    '反馈': 'menu_list_three',
    '设置': 'menu_list_four',
    '关于App': 'menu_list_five',
    '百度一下': 'menu_list_six',
    '关于我': 'menu_list_seven'
  };

  var name;

  

  @override
  void initState() {
    super.initState();
    name = SharedUtil.getInstance().get(SharedKey.USER_NAME, '');
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildMyInfo() {
    return ClipPath(
        clipper: BottomClipper(),
        child: Container(
          color: Colors.blue,
          width: MediaQuery.of(context).size.width,
          height: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: _header == null
                    ? loadAssetImage('img_header', width: 80.0, height: 80.0)
                    : ClipOval(
                        child: SizedBox(
                          width: 80.0,
                          height: 80.0,
                          child: Image.file(
                            _header,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                onTap: () {
                  _showModifyHeader(context);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Consumer<LoginProvider>(
                builder: (context, LoginProvider provider, _) {
                  return Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          if (!provider.isLogin) {
                            RouteUtil.pushNamed(
                                context, RouteConfig.loginName);
                          }
                        },
                        child: Text(
                          provider.isLogin ? '名字为空' : '登陆',
                          style: TextStyles.whiteBold16,
                        ),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ));
  }

  Container _buildMenu() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildMenuBtn('img_menu_two', '星座配对', () {
            RouteUtil.pushWidget(context, PairingPage(flag: true));
          }),
          _buildMenuBtn('img_menu_three', '生肖配对', () {
            RouteUtil.pushWidget(context, PairingPage(flag: false));
          }),
        ],
      ),
    );
  }

  GestureDetector _buildMenuBtn(
      String imgPath, String label, Function callBack) {
    return GestureDetector(
      onTap: callBack,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          loadAssetImage(imgPath, width: 40.0, height: 40.0),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              label,
              style: TextStyles.textMain12,
            ),
          )
        ],
      ),
    );
  }

  Column _buildItem(label, imagePath) {
    return Column(
      children: <Widget>[
        Container(
          child: ListTile(
            title: Text(label, style: TextStyles.mainNormal14),
            leading: loadAssetImage(imagePath, width: 30.0, height: 30.0),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              switch (label) {
                case '历史上的今天':
                  RouteUtil.pushNamed(context, RouteConfig.todayName);
                  break;
                case '周公解梦':
                  RouteUtil.pushNamed(context, RouteConfig.dreamName);
                  break;
                case '反馈':
                  RouteUtil.pushNamed(context, RouteConfig.feedBackName);
                  break;
                case '设置':
                  RouteUtil.pushNamed(context, RouteConfig.settingName);
                  break;
                case '关于App':
                  RouteUtil.pushNamed(context, RouteConfig.stepName);
                  break;
                case '百度一下':
                  if (Platform.isAndroid) {
                    go2Web();
                  }
                  break;
                case '关于我':
                  if (Platform.isAndroid) {
                    go2AboutMe();
                  }
                  break;
                default:
              }
            },
          ),
        ),
        Divider(
          height: 0.5,
        )
      ],
    );
  }

  _buildMenuList() {
    List<Widget> items = [];
    menus.forEach((title, imgpath) {
      items.add(_buildItem(title, imgpath));
    });
    return Wrap(
      children: items,
    );
  }

  Future<Null> go2AboutMe() async {
    try {
      final String result = await methodChannel.invokeMethod('go2AboutMe');
      print(result);
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Future<Null> go2Web() async {
    try {
      var url = 'https://www.baidu.com';
      final String result = await webChannel.invokeMethod('go2Web', url);
      print(result);
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('我的'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        actions: <Widget>[
          Consumer<LoginProvider>(
            builder: (context, LoginProvider provider, _) {
              return FlatButton(
                onPressed: () {
                  if (provider.isLogin) {
                    RouteUtil.pushWidget(
                        context, MyInfoSettingPage(name: name));
                  } else {
                    RouteUtil.pushNamed(context, RouteConfig.loginName);
                  }
                },
                child: Text(
                  '设置',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            _buildMyInfo(),
            _buildMenu(),
            Divider(
              height: 0.5,
            ),
            _buildMenuList(),
          ],
        ),
      ),
    );
  }

  _showModifyHeader(context) async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomPhotoView(() {
            ImagePicker.pickImage(source: ImageSource.camera).then((file) {
              setState(() {
                _header = file;
              });
            });
          }, () {
            ImagePicker.pickImage(source: ImageSource.gallery).then((file) {
              setState(() {
                _header = file;
              });
            });
          });
        });
  }
}
