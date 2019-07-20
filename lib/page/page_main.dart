import 'package:flutter/material.dart';
import 'package:Inke/module_movie/page_movie.dart';
import 'package:Inke/module_action/page_action.dart';
import 'package:Inke/module_my/page_my.dart';
import 'package:Inke/module_news/page_news.dart';
import 'package:Inke/util/image_util.dart';


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
          loadAssetImage('nav_movie',width: 25.0,height: 25.0),
          loadAssetImage('nav_movie_selected',width: 25.0,height: 25.0),
        ],
        [
          loadAssetImage('nav_action',width: 25.0,height: 25.0),
          loadAssetImage('nav_action_selected',width: 25.0,height: 25.0),
        ],
        [
          loadAssetImage('nav_music',width: 25.0,height: 25.0),
          loadAssetImage('nav_music_selected',width: 25.0,height: 25.0),
        ],
        [
          loadAssetImage('nav_my',width: 25.0,height: 25.0),
          loadAssetImage('nav_my_selected',width: 25.0,height: 25.0),

        ]
      ];
    }
  }


  Image _getTabIcon(int index) {
    if (index == _currentIndex) {
      return tabImages[index][1];
    } else {
      return tabImages[index][0];
    }
  }

  Widget _getTabTitle(int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Text(
        titles[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildBody(),
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
    );
  }

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

}
