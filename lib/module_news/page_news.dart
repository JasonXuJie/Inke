import 'package:flutter/material.dart';
import 'package:Inke/module_news/news_list_view.dart';
import 'package:Inke/util/route_util.dart';
import 'package:Inke/config/route_config.dart';

class NewsPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<NewsPage> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {
  final Map<String, String> map = Map();
  TabController _controller;

  @override
  void initState() {
    super.initState();
    print('News initState');
    map['头条'] = 'top';
    map['国内'] = 'guonei';
    map['国际'] = 'guoji';
    _controller = TabController(length: map.length, vsync: this);
  }

  @override
  bool get wantKeepAlive => true;



  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onTap: () =>
                RouteUtil.pushByNamed(context, RouteConfig.searchName),
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
        body: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              height: 40.0,
              child: Center(
                child: TabBar(
                  controller: _controller,
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
              ),
            ),
            Expanded(
              child: TabBarView(
                children: _buildViews(),
                controller: _controller,
              ),
            ),
          ],
        ));
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
