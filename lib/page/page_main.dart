import 'package:flutter/material.dart';
import '../module_movie/page_movie.dart';
import '../module_action/page_action.dart';
import '../module_my/page_my.dart';
import '../module_news/page_news.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import '../config/app_config.dart';


class MainPage extends StatefulWidget {

  @override
  _State createState() => _State();
}

class _State extends State<MainPage>{

  int _currentIndex = 0;
  final List<String> titles = ['电影', '活动', '资讯', '我的'];
  var tabImages;
  final _pageController = PageController();



  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    if (tabImages == null) {
      tabImages = [
        [
          _renderTabIcon(AppImgPath.mainPath+'nav_movie.png'),
          _renderTabIcon(AppImgPath.mainPath+'nav_movie_selected.png'),
        ],
        [
          _renderTabIcon(AppImgPath.mainPath+'nav_action.png'),
          _renderTabIcon(AppImgPath.mainPath+'nav_action_selected.png'),
        ],
        [
          _renderTabIcon(AppImgPath.mainPath+'nav_music.png'),
          _renderTabIcon(AppImgPath.mainPath+'nav_music_selected.png'),
        ],
        [
          _renderTabIcon(AppImgPath.mainPath+'nav_my.png'),
          _renderTabIcon(AppImgPath.mainPath+'nav_my_selected.png'),
        ]
      ];
    }
  }

  Image _renderTabIcon(path) {
    return Image.asset(
      path,
      width: 20.0,
      height: 20.0,
    );
  }

  Image _getTabIcon(int index) {
    if (index == _currentIndex) {
      return tabImages[index][1];
    } else {
      return tabImages[index][0];
    }
  }

  Text _getTabTitle(int index) {
    var color;
    if (index == _currentIndex) {
      color = Colors.blue;
    } else {
      color = Color(0xff969696);
    }
    return Text(
      titles[index],
      style: TextStyle(color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.blue,
          currentIndex: _currentIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
                icon: _getTabIcon(0), title: _getTabTitle(0)),
            BottomNavigationBarItem(
                icon: _getTabIcon(1), title: _getTabTitle(1)),
            BottomNavigationBarItem(
              icon: _getTabIcon(2),
              title: _getTabTitle(2),
            ),
            BottomNavigationBarItem(
                icon: _getTabIcon(3), title: _getTabTitle(3))
          ]),
    );
  }

  //调用这个方法会初始化里面所有的子视图
//  _buildBody() {
//    return IndexedStack(
//      children: <Widget>[
//        MovieFragment(),
//        ActionFragment(),
//        NewsPage(),
//        MyIndex(),
//      ],
//      index: _currentIndex,
//    );
//  }

  _buildBody(){
    return PageView(
      controller: _pageController,
      onPageChanged: onPageChanged,
      children: <Widget>[
        MovieFragment(),
        ActionFragment(),
        NewsPage(),
        MyIndex(),
      ],
      physics: NeverScrollableScrollPhysics(),//禁止滑动
    );
  }

  void onTap(int index){
    _pageController.jumpToPage(index);
  }

  void onPageChanged(int index){
      setState(() {
        _currentIndex = index;
      });
  }

//  _buildBody(){
//    switch(_currentIndex){
//      case 0:
//        return MovieFragment();
//        break;
//      case 1:
//        return ActionFragment();
//        break;
//      case 2:
//        return NewsPage();
//        break;
//      case 3:
//        return MyIndex();
//        break;
//    }
//  }



  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  void setStateBarColor(int index) async {
    switch (index) {
      case 0:
        await FlutterStatusbarManager.setFullscreen(true);
        break;
      case 1:
        await FlutterStatusbarManager.setColor(Colors.white);
        await FlutterStatusbarManager.setFullscreen(false);
        await FlutterStatusbarManager.setTranslucent(false);
        await FlutterStatusbarManager.setStyle(StatusBarStyle.DARK_CONTENT);
        break;
      default:
        await FlutterStatusbarManager.setColor(Color(AppColors.C_0099FD));
        await FlutterStatusbarManager.setFullscreen(false);
        await FlutterStatusbarManager.setTranslucent(false);
        await FlutterStatusbarManager.setStyle(StatusBarStyle.LIGHT_CONTENT);
    }
  }


}
