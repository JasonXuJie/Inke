import 'package:flutter/material.dart';
import 'package:Inke/config/route_config.dart';
import 'package:Inke/widgets/text.dart';
import 'package:Inke/module_news/list_news.dart';


class NewsPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<NewsPage> with AutomaticKeepAliveClientMixin {

  final Map<String, String> tabs = {'头条': 'top', '国内': 'guonei', '国际': 'guoji'};

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: tabs.keys.length,
      child: Scaffold(
          appBar: AppBar(
            title: GestureDetector(
              onTap: () => RouteUtil.pushNamed(context, RouteName.searchName),
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
                          child: Text('请输入要搜索的内容',
                              style: TextStyles.greyNormal13)),
                    )
                  ],
                ),
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: true,
            bottom: _buildTabBar(),
          ),
          body: TabBarView(
              children: List.generate(tabs.values.length,
                  (index) => NewsList(value: tabs.values.elementAt(index))))),
    );
  }

  Widget _buildTabBar(){
    return TabBar(
        isScrollable: true,
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: Colors.white,
        labelColor: Colors.white,
        unselectedLabelStyle: const TextStyle(
          fontSize: 14.0,
        ),
        labelStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
        tabs: List.generate(
            tabs.keys.length,
                (index) => Tab(
              text: tabs.keys.elementAt(index),
            ))
    );
  }
}
