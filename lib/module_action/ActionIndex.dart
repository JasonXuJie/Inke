import 'package:flutter/material.dart';
import 'components/ActionList.dart';
import '../config/AppConfig.dart';
import '../config/Colors.dart' as AppColors;

class ActionFragment extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ActionFragment>
    with SingleTickerProviderStateMixin {
  final Map<String, Tab> map = Map();

  TabController _controller;
  var _tags = ['将来','本周','周末','今日','明日'];
  int mValue =0;
  var cityName = '上海';

  @override
  void initState() {
    super.initState();
    _init();
    _controller = TabController(length: map.length, vsync: this);
  }

  @override
  void dispose() {
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
        backgroundColor: Colors.white,
        title: Text(
          '同城活动',
          style: const TextStyle(color: Color(0XFFFF9900)),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        bottom: TabBar(
            isScrollable: true,
            controller: _controller,
            indicatorColor: Color(0XFFFF9900),
            labelColor: Color(0XFFFF9900),
            labelStyle:
                const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.black38,
            unselectedLabelStyle: const TextStyle(fontSize: 12.0),
            tabs: _buildTabs()),
        actions: <Widget>[
            _renderPopMenu()
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 5.0,bottom: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List<Widget>.generate(_tags.length,(int index){
                return ChoiceChip(
                  label: Text(_tags[index]),
                  labelStyle: const TextStyle(color: Colors.white),
                  selected: mValue == index,
                  backgroundColor: Colors.black38,
                  selectedColor: Color(AppColors.Colors.C_FF9900),
                  onSelected: (bool selected){
                    setState(() {
                    mValue = selected ? index : null;
                  });
                  },
                );
            }),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: _buildTabViews(),
              controller: _controller,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(AppColors.Colors.C_FF9900),
        isExtended: true,
        child: Image.asset(
          AppImgPath.mainPath + 'app_icon.png',
          width: 25.0,
          height: 25.0,
        ),
      ),

    );
  }

  List<Tab> _buildTabs() {
    List<Tab> tabs = [];
    map.values.forEach((tab) {
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

  _renderPopMenu() {
    return PopupMenuButton<int>(
      icon: Icon(Icons.more_vert,color: Color(AppColors.Colors.C_FF9900),),
      onSelected: (int value) {
        switch (value) {
          case 0:
            //scan();
            break;
          case 1:
            Navigator.pushNamed(context, '/City').then((result) {
              setState(() {
                cityName = result;

              });
            });
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: <Widget>[Icon(Icons.scanner), Text('扫一扫')],
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: <Widget>[Icon(Icons.location_city), Text(cityName)],
          ),
        ),
      ],
    );
  }
}
