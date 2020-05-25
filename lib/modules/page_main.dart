import 'package:flutter/material.dart';
import 'package:Inke/modules/movie/container_movie.dart';
import 'package:Inke/modules/action/container_action.dart';
import 'package:Inke/modules/my/container_my.dart';
import 'package:Inke/modules/news/container_news.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/config/colors.dart';
import 'package:Inke/util/toast.dart';

class MainPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MainPage> {
  int _currentIndex = 0;
  final List<String> titles = ['电影', '活动', '资讯', '我的'];
  var tabImages = [
    [
      loadAssetImage('nav_movie', width: 25.0, height: 25.0),
      loadAssetImage('nav_movie_selected', width: 25.0, height: 25.0),
    ],
    [
      loadAssetImage('nav_action', width: 25.0, height: 25.0),
      loadAssetImage('nav_action_selected', width: 25.0, height: 25.0),
    ],
    [
      loadAssetImage('nav_music', width: 25.0, height: 25.0),
      loadAssetImage('nav_music_selected', width: 25.0, height: 25.0),
    ],
    [
      loadAssetImage('nav_my', width: 25.0, height: 25.0),
      loadAssetImage('nav_my_selected', width: 25.0, height: 25.0),
    ]
  ];
  final _pageController = PageController();
  int firstTime = 0;

  Image _getTabIcon(int index) {
    if (index == _currentIndex) {
      return tabImages[index][1];
    } else {
      return tabImages[index][0];
    }
  }

  Widget _getTabTitle(int index) {
    var color;
    if (index == _currentIndex) {
      color = AppColors.color_0099fd;
    } else {
      color = AppColors.black;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Text(
        titles[index],
        style: TextStyle(color: color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            MovieContainer(),
            ActionContainer(),
            NewsContainer(),
            MyContainer(),
          ],
          physics: NeverScrollableScrollPhysics(), //禁止滑动
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: onTap,
            iconSize: 10.0,
            selectedFontSize: 13.0,
            unselectedFontSize: 13.0,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Color(0xff969696),
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
            ///中间凸出底部导航
        // bottomNavigationBar: BottomAppBar(
        //   child: Container(
        //     height: 55.0,
        //     padding: const EdgeInsets.only(top: 5.0),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: <Widget>[
        //         buildNavigationItem(0, () {
        //           onTap(0);
        //         }),
        //         buildNavigationItem(1, () {
        //           onTap(1);
        //         }),
        //         Flexible(
        //           flex: 1,
        //           child: Container(width: 25.0, height: 25.0),
        //         ),
        //         buildNavigationItem(2, () {
        //           onTap(2);
        //         }),
        //         buildNavigationItem(3, () {
        //           onTap(3);
        //         })
        //       ],
        //     ),
        //   ),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: Icon(Icons.add),
        // ),
      ),
      onWillPop: () {
        ///双击退出
        int secondTime = DateTime.now().millisecondsSinceEpoch;
        if (secondTime - firstTime > 2000) {
          Toast.show('再按一次退出程序');
          firstTime = secondTime;
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
    );
  }

  void onTap(int index) {
    _pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget buildNavigationItem(int position, Function onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: <Widget>[_getTabIcon(position), _getTabTitle(position)],
      ),
    );
  }
}
