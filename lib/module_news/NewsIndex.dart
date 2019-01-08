import 'package:flutter/material.dart';
import 'components/NewsList.dart';

class NewsPage extends StatelessWidget {
  final Map<String, String> map = Map();

  NewsPage() {
    initMap();
  }

  void initMap() {
    map['头条'] = 'top';
    map['社会'] = 'shehui';
    map['国内'] = 'guonei';
    map['国际'] = 'guoji';
    map['娱乐'] = 'yule';
    map['体育'] = 'tiyu';
    map['军事'] = 'junshi';
    map['科技'] = 'keji';
    map['财经'] = 'caijing';
    map['时尚'] = 'shishang';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/Search'),
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    '请输入要搜索的内容',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13.0,
                    ),
                  )),
                )
              ],
            ),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: DefaultTabController(
          length: map.length,
          child: Scaffold(
            appBar: TabBar(
              isScrollable: true,
              indicatorColor: Colors.blue,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.black,
              labelColor: Colors.blue,
              unselectedLabelStyle: const TextStyle(
                fontSize: 14.0,
              ),
              labelStyle: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
              tabs: _buildTabs(),
            ),
            body: TabBarView(children: _buildViews()),
          )),
    );
  }

  _buildTabs() {
    List<Tab> tabs = [];
    map.keys.forEach((key) {
      var tab = Tab(
        text: key,
      );
      tabs.add(tab);
    });
    return tabs;
  }

  _buildViews() {
    List<Widget> containers = [];
    map.values.forEach((value) {
      containers.add(NewsList(
        value: value,
      ));
    });
    return containers;
  }
}
