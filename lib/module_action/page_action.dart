import 'package:Inke/provider/city_provider.dart';
import 'package:flutter/material.dart';
import 'package:Inke/config/route_config.dart';
import 'package:Inke/event/event_scroll_top.dart';
import 'package:Inke/util/event_util.dart';
import 'package:provider/provider.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/config/colors.dart';
import 'package:Inke/module_action/list_action.dart';

class ActionFragment extends StatefulWidget {
  @override
  _ActionState createState() => _ActionState();
}

class _ActionState extends State<ActionFragment>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _controller;
  final Map<String, Tab> tabs = {
    'all': Tab(text: '所有'),
    'music': Tab(text: '音乐'),
    'film': Tab(text: '电影'),
    'drama': Tab(text: '戏剧'),
    'commonweal': Tab(text: '公益'),
    'salon': Tab(text: '讲座'),
    'exhibition': Tab(text: '展览'),
    'party': Tab(text: '聚会'),
    'travel': Tab(text: '旅行'),
    'others': Tab(text: '其他')
  };
  final _tags = ['将来', '本周', '周末', '今日', '明日'];
  int mValue = 0;
  var dateType = 'future';
  final _choice = ['所有', '音乐', '电影', '戏剧', '公益', '讲座', '展览', '聚会', '旅行', '其他'];

 

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
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
        backgroundColor: Colors.white,
        title: Text(
          '同城活动',
          style: const TextStyle(color: AppColors.color_ff9900),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[_renderPopMenu()],
        bottom: AppBar(
          backgroundColor: Colors.white,
          title: Stack(
            children: <Widget>[
              _renderDrop(),
              Container(
                color: Colors.white,
                margin: const EdgeInsets.only(right: 25),
                child: TabBar(
                    isScrollable: true,
                    controller: _controller,
                    indicatorColor: AppColors.color_ff9900,
                    labelColor: AppColors.color_ff9900,
                    labelStyle: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                    unselectedLabelColor: Colors.black38,
                    unselectedLabelStyle: const TextStyle(fontSize: 12.0),
                    tabs: List.generate(tabs.values.length,
                        (index) => tabs.values.toList()[index])),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List<Widget>.generate(_tags.length, (int index) {
                return ChoiceChip(
                  label: Text(_tags[index]),
                  labelStyle: const TextStyle(color: Colors.white),
                  selected: mValue == index,
                  backgroundColor: Colors.black38,
                  selectedColor: AppColors.color_ff9900,
                  onSelected: (bool selected) {
                    if (selected) {
                      setState(() {
                        mValue = selected ? index : null;
                        switch (index) {
                          case 0:
                            setState(() {
                              dateType = 'future';
                            });
                            break;
                          case 1:
                            setState(() {
                              dateType = 'week';
                            });
                            break;
                          case 2:
                            setState(() {
                              dateType = 'weekend';
                            });
                            break;
                          case 3:
                            setState(() {
                              dateType = 'today';
                            });
                            break;
                          case 4:
                            setState(() {
                              dateType = 'tomorrow';
                            });
                            break;
                        }
                      });
                    }
                  },
                );
              }),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: List.generate(tabs.keys.length,
                  (index) => ActionList(type: tabs.keys.toList()[index],dateType: dateType,)),
              controller: _controller,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          EventUtil.getInstance().post(ScrollTopEvent());
        },
        backgroundColor: AppColors.color_ff9900,
        isExtended: true,
        child: loadAssetImage('app_icon', width: 25.0, height: 25.0),
      ),
    );
  }

  Widget _renderDrop() {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: _choice[0],
        elevation: 0,
        style: Theme.of(context).primaryTextTheme.subhead,
        items: List.generate(_choice.length, (int pos) {
          return DropdownMenuItem<String>(
            value: _choice[pos],
            child: Text(
              _choice[pos],
              style: TextStyle(color: Colors.black),
            ),
          );
        }),
        onChanged: (String newValue) {
          _controller.animateTo(_choice.indexOf(newValue));
        },
        isExpanded: true,
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
        ),
      ),
    );
  }

  _renderPopMenu() {
    return PopupMenuButton<int>(
      icon: Icon(
        Icons.more_vert,
        color: AppColors.color_ff9900,
      ),
      onSelected: (int value) {
        switch (value) {
          case 0:
            break;
          case 1:
            RouteUtil.pushNamed(context, RouteName.cityName);
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: <Widget>[
              Icon(Icons.scanner),
              SizedBox(
                width: 10,
              ),
              Text('扫一扫')
            ],
          ),
        ),
        PopupMenuDivider(
          height: 1.0,
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Consumer<CityProvider>(
            builder: (context, CityProvider provider, _) {
              return Row(
                children: <Widget>[
                  Icon(Icons.location_city),
                  SizedBox(
                    width: 10,
                  ),
                  Text(provider.name)
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}


