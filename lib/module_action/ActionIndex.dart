import 'package:flutter/material.dart';
import 'components/ActionList.dart';

class ActionFragment extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ActionState();
}

class _ActionState extends State<ActionFragment> with SingleTickerProviderStateMixin
     {

  final Map<String, Tab> map = Map();

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _init();
    _controller = TabController(length: map.length, vsync: this);
  }

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }



  _init() {
    map['all'] = Tab(
      text: '所有',
    );
    map['music'] = Tab(
      text: '音乐',
    );
    map['film'] = Tab(
      text: '电影',
    );
    map['drama'] = Tab(
      text: '戏剧',
    );
    map['commonweal'] = Tab(
      text: '公益',
    );
    map['salon'] = Tab(
      text: '讲座',
    );
    map['exhibition'] = Tab(
      text: '展览',
    );
    map['party'] = Tab(
      text: '聚会',
    );
    map['travel'] = Tab(
      text: '旅行',
    );
    map['others'] = Tab(
      text: '其他',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('同城活动'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        bottom: TabBar(
            isScrollable: true,
            controller: _controller,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: _buildTabs()
        ),
      ),
      body: TabBarView(
        children: _buildTabViews(),
        controller: _controller,
      )
    );
  }


  List<Tab> _buildTabs(){
    List<Tab> tabs =[];
    map.values.forEach((tab){
      tabs.add(tab);
    });
    return tabs;
  }

  List<Widget> _buildTabViews() {
    List<Widget> list = [];
    map.keys.forEach((value) {
      list.add(EventList(value));
    });
    return list;
  }
}
