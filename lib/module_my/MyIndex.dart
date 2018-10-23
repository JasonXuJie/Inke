import 'package:flutter/material.dart';
import 'AboutPage.dart';
import '../components/AnimationPageRoute.dart';
import '../config/AppConfig.dart';
import 'MySetting.dart';
import '../util/PermissionUtil.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'Pairing.dart';

class MyIndex extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => _MyIndexState();
}

class _MyIndexState extends State<MyIndex> {

  static const methodChannel = const MethodChannel('com.jason.myfluttertest/module_my');
  static const webChannel = const MethodChannel('com.jason.myfluttertest/web');
  File _header;

  var titles = [
    'menu_one',
    'menu_two',
    'menu_three',
    'menu_four',
    '设置',
    '百度一下',
    '关于我'
  ];

  var imgPath = [
    AppImgPath.mainPath + 'menu_list_one.png',
    AppImgPath.mainPath + 'menu_list_two.png',
    AppImgPath.mainPath + 'menu_list_three.png',
    AppImgPath.mainPath + 'menu_list_four.png',
    AppImgPath.mainPath + 'menu_list_five.png',
    AppImgPath.mainPath + 'menu_list_six.png',
    AppImgPath.mainPath + 'menu_list_seven.png'
  ];

  var name = 'J@son';
  var motto = 'Talk is cheap!Show me the Code!';

  @override
  Widget build(BuildContext context) {
    Container _buildMyInfo() {
      return Container(
        color: Colors.blue,
        width: MediaQuery.of(context).size.width,
        height: 160.0,
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 15.0),
        child: Wrap(
          direction: Axis.vertical,
          runAlignment: WrapAlignment.center,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 3.0,
          children: <Widget>[
            GestureDetector(
              child: _header==null?Image.asset(
                AppImgPath.mainPath + 'img_header.png',
                width: 60.0,
                height: 60.0,
              ):Image.file(_header,width: 60.0,height: 60.0,),
              onTap: () {
                _showModifyHeader(context);
              },
            ),
            Text(
              name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'motto:' + motto,
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          ],
        ),
      );
    }

    GestureDetector _buildMenuBtn(imgPath, label) {
      Color color = Theme.of(context).primaryColor;
      return GestureDetector(
        onTap: () {
          switch (label) {
            case '星座运势':
              Navigator.pushNamed(context, '/Constellation');
              break;
            case '星座配对':
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PairingPage(flag: true)));
              break;
            case '生肖配对':
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PairingPage(flag: false)));
              break;
          }
        },
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

    Container _buildMenu() {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildMenuBtn(AppImgPath.mainPath + 'img_menu_one.png', '星座运势'),
            _buildMenuBtn(AppImgPath.mainPath + 'img_menu_two.png', '星座配对'),
            _buildMenuBtn(AppImgPath.mainPath + 'img_menu_three.png', '生肖配对'),
          ],
        ),
      );
    }

    Future<Null> go2AboutMe()async{
      try{
         final String result = await methodChannel.invokeMethod('go2AboutMe');
         print(result);
      }on PlatformException catch(e){
        print(e.message);
      }
    }

    Future<Null> go2Web()async{
      try{
        var url = 'https://www.baidu.com';
        final String result = await webChannel.invokeMethod('go2Web',url);
        print(result);
      }on PlatformException catch(e){
        print(e.message);
      }
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
                  case 4:
                    Navigator.pushNamed(context, '/Setting');
                    break;
                  case 5:
                    go2Web();
                    break;
                  case 6:
                    go2AboutMe();
//                    Navigator.push(
//                        context,
//                        AnimationPageRoute(
//                            slideTween: Tween<Offset>(
//                                begin: Offset(1.0, 0.0), end: Offset.zero),
//                            builder: (ctx) => AboutPage()));
                    break;
                }
              },
            ),
          ),
          divider
        ],
      );
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

    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyInfoSettingPage(
                    name: name,
                    motto: motto,
                  );
                })).then((result) {
                  setState(() {
                    name = result[0];
                    motto = result[1];
                  });
                });
              },
              child: Text(
                '设置',
                style: TextStyle(color: Colors.white),
              )),
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

  _showModifyHeader(context){
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 152.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                    child: Center(
                      child: Text(
                        '拍照',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: () {
                    pickHeader(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                Divider(
                  height: 1.0,
                  color: Color(AppColors.windowBackground),
                ),
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                    child: Center(
                      child: Text(
                        '从相册选取',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: () {
                    pickHeader(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                Divider(
                  height: 1.0,
                  color: Color(AppColors.windowBackground),
                ),
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                    child: Center(
                      child: Text(
                        '取消',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });
  }

  Future pickHeader(ImageSource source)async{
    ImagePicker.pickImage(source: source).then((file){
      setState(() {
        _header = file;
      });
    });
  }

}
