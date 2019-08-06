import 'package:flutter/material.dart';
import 'package:Inke/util/route_util.dart';
import 'package:Inke/config/route_config.dart';
import 'package:Inke/config/app_config.dart';
import 'page_my_setting.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'page_pairing.dart';
import 'package:Inke/util/shared_util.dart';
import 'package:Inke/config/shared_key.dart';
import 'package:Inke/widgets/bottom_photo_view.dart';
import 'package:Inke/module_my/page_setting.dart';
import 'package:provider/provider.dart';
import 'package:Inke/provider/login_provider.dart';

class MyIndex extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyIndex> with AutomaticKeepAliveClientMixin{
  var methodChannel = const MethodChannel('com.jason.myfluttertest/module_my');
  var webChannel = const MethodChannel('com.jason.myfluttertest/web');
  File _header;

  final titles = ['历史上的今天', '周公解梦', '反馈', '设置', 'menu_five', '百度一下', '关于我'];

  final imgPath = [
    AppImgPath.mainPath + 'menu_list_one.png',
    AppImgPath.mainPath + 'menu_list_two.png',
    AppImgPath.mainPath + 'menu_list_three.png',
    AppImgPath.mainPath + 'menu_list_four.png',
    AppImgPath.mainPath + 'menu_list_five.png',
    AppImgPath.mainPath + 'menu_list_six.png',
    AppImgPath.mainPath + 'menu_list_seven.png'
  ];

  var name;

  @override
  void initState() {
    super.initState();
    print('My initState');
    name = SharedUtil.getInstance().get(SharedKey.USER_NAME, '');
  }

  @override
  bool get wantKeepAlive => true;


  Container _buildMyInfo() {
    return Container(
      color: Colors.blue,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 15.0),
      child: Wrap(
        direction: Axis.vertical,
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 3.0,
        children: <Widget>[
          GestureDetector(
            child: _header == null
                ? Image.asset(
                    AppImgPath.mainPath + 'img_header.png',
                    width: 80.0,
                    height: 80.0,
                  )
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
          Consumer<LoginProvider>(
            builder: (context,LoginProvider provider,_){
              return Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      if (!provider.isLogin) {
                        RouteUtil.pushByNamed(
                            context, RouteConfig.loginName);
                      }
                    },
                    child: Text(
                      provider.isLogin ? '名字为空' : '登陆',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Container _buildMenu() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildMenuBtn(AppImgPath.mainPath + 'img_menu_two.png', '星座配对', () {
            RouteUtil.pushByWidget(context, PairingPage(flag: true));
          }),
          _buildMenuBtn(AppImgPath.mainPath + 'img_menu_three.png', '生肖配对', () {
            RouteUtil.pushByWidget(context, PairingPage(flag: false));
          }),
        ],
      ),
    );
  }

  GestureDetector _buildMenuBtn(imgPath, label, callBack) {
    Color color = Theme.of(context).primaryColor;
    return GestureDetector(
      onTap: callBack,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            imgPath,
            width: 40.0,
            height: 40.0,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 15.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  Column _buildItem(label, imagePath, index) {
    var divider;
    if (index == 1 || index == 4) {
      divider = Divider(
        color: Colors.transparent,
        height: 10.0,
      );
    } else {
      divider = Divider(
        color: Colors.transparent,
        height: 1.0,
      );
    }
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: ListTile(
            title: Text(
              label,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            leading: Image.asset(
              imagePath,
              width: 30.0,
              height: 30.0,
            ),
            trailing: Image.asset(
              AppImgPath.mainPath + 'img_right_arrow.png',
              width: 10.0,
              height: 10.0,
            ),
            onTap: () {
              switch (index) {
                case 0:
                  RouteUtil.pushByNamed(context, RouteConfig.todayName);
                  break;
                case 1:
                  RouteUtil.pushByNamed(context, RouteConfig.dreamName);
                  break;
                case 2:
                  RouteUtil.pushByNamed(context, RouteConfig.feedBackName);
                  break;
                case 3:
                  RouteUtil.pushByNamed(context, RouteConfig.settingName);
                  break;
                case 4:
                  break;
                case 5:
                  if (Platform.isAndroid) {
                    go2Web();
                  }
                  break;
                case 6:
                  if (Platform.isAndroid) {
                    go2AboutMe();
                  }
                  break;
                default:
              }
            },
          ),
        ),
        divider
      ],
    );
  }


  void jump(context){
    Navigator.push(context, PageRouteBuilder(pageBuilder:
        (BuildContext context, Animation animation,
        Animation secondaryAnimation) {
      return ScaleTransition(
          scale: animation,
          alignment: Alignment.center,
          child: SettingPage());
    }));
  }


  void jump2(context){
    Navigator.push(context, PageRouteBuilder(pageBuilder:
        (BuildContext context, Animation animation,
        Animation secondaryAnimation) {
      return FadeTransition(
          opacity: animation,
          child: SettingPage());
    }));
  }

  void jump3(context){
    Navigator.push(context, PageRouteBuilder(pageBuilder:
        (BuildContext context, Animation animation,
        Animation secondaryAnimation) {
      return RotationTransition(
          alignment: Alignment.center,
          turns: animation,
          child: SettingPage());
    }));
  }

  void jump4(context){
    Navigator.push(context, PageRouteBuilder(pageBuilder:
        (BuildContext context, Animation animation,
        Animation secondaryAnimation) {
      return SlideTransition(
          position: animation,
          child: SettingPage());
    }));
  }

  _buildMenuList() {
    List<Widget> items = [];
    List<Widget>.generate(titles.length, (index) {
      items.add(_buildItem(titles[index], imgPath[index], index));
    });
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Wrap(
        children: items,
      ),
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
    print('My build');
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        actions: <Widget>[
          Consumer<LoginProvider>(
            builder: (context,LoginProvider provider,_){
              return FlatButton(
                onPressed: () {
                  if (provider.isLogin) {
                    RouteUtil.pushByWidget(
                        context, MyInfoSettingPage(name: name));
                  } else {
                    RouteUtil.pushByNamed(context, RouteConfig.loginName);
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
            _buildMenuList(),
          ],
        ),
      ),
    );
  }

  _showModifyHeader(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomPhotoView(() {
            pickHeader(ImageSource.camera);
          }, () {
            pickHeader(ImageSource.gallery);
          });
        });
  }

  Future pickHeader(ImageSource source) async {
    ImagePicker.pickImage(source: source).then((file) {
      setState(() {
        _header = file;
      });
    });
  }




}
