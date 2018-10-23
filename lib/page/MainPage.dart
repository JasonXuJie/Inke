import 'package:flutter/material.dart';
import '../module_movie/MovieIndex.dart';
import '../module_action/ActionIndex.dart';
import '../module_my/MyIndex.dart';
import '../module_news/NewsIndex.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainState();
}

class _MainState extends State<MainPage> {
  int _currentIndex = 0;
  final List<String> titles = ['电影', '活动', '资讯', '我的'];
  var tabImages;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    if (tabImages == null) {
      tabImages = [
        [
          _renderTabIcon('images/nav_movie.png'),
          _renderTabIcon('images/nav_movie_selected.png'),
        ],
        [
          _renderTabIcon('images/nav_action.png'),
          _renderTabIcon('images/nav_action_selected.png'),
        ],
        [
          _renderTabIcon('images/nav_music.png'),
          _renderTabIcon('images/nav_music_selected.png'),
        ],
        [
          _renderTabIcon('images/nav_my.png'),
          _renderTabIcon('images/nav_my_selected.png'),
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
      body: _renderBody(),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.blue,
          currentIndex: _currentIndex,
          onTap: _onTapped,
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

  _renderBody() {
    return IndexedStack(
      children: <Widget>[
        MovieFragment(),
        ActionFragment(),
        NewsPage(),
        MyIndex(),
      ],
      index: _currentIndex,
    );
  }

  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
