import 'package:flutter/material.dart';
import 'package:Inke/module_movie/list_coming_soon.dart';
import 'package:Inke/module_movie/list_top.dart';
import 'package:Inke/widgets/text.dart';


class ClassifyView extends StatefulWidget{

  @override
  State<StatefulWidget> createState() =>_State();

}



class _State extends State<ClassifyView> with SingleTickerProviderStateMixin{

  final tabs = [Tab(text: '即将上映'), Tab(text: 'Top250榜单'),Tab(text: '其它',)];

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTabBar(),
        Expanded(
            child: TabBarView(
                controller: _tabController,
                children: [
                  ComingSoonList(),
                  TopList(),
                  OtherWidget(),
                ]
            )
        )
      ],
    );
  }

  Widget _buildTabBar(){
      return TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.redAccent,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.black,
          unselectedLabelStyle: const TextStyle(
            fontSize: 16.0,
          ),
          labelStyle: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          tabs: tabs
      );
  }
}




///其它功能
class OtherWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('功能暂未开放'),
    );
  }
}

