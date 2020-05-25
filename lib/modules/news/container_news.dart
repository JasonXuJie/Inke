import 'package:flutter/material.dart';
import 'package:Inke/widgets/text.dart';
import 'package:Inke/modules/news/grid_news.dart';
import 'package:Inke/router/routes.dart';
import 'package:Inke/router/navigator_util.dart';


class NewsContainer extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<NewsContainer> with AutomaticKeepAliveClientMixin {

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
            title: _buildSearchBar(),
            bottom: _buildTabBar(),
          ),
          body: TabBarView(
              children: List.generate(tabs.values.length,
                  (index) => NewsList(value: tabs.values.elementAt(index))))),
    );
  }



  Widget _buildSearchBar(){
    return GestureDetector(
      onTap: () => NavigatorUtil.push(context, Routes.search),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
            Center(
                child: Text('请输入要搜索的内容',
                    style: TextStyles.greyNormal13))
          ],
        ),
      ),
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
