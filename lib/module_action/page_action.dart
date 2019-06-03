import 'package:flutter/material.dart';
import 'package:Inke/module_action//action_list_view.dart';
import 'package:Inke/config/app_config.dart';
import 'package:Inke/util/qr_scan_util.dart';
import 'package:Inke/util/route_util.dart';
import 'package:Inke/config/route_config.dart';
import 'package:Inke/event/event_scroll_top.dart';
import 'package:Inke/util/event_util.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:Inke/bean/city.dart';
import 'package:Inke/redux/global_state.dart';
import 'package:Inke/redux/action_date_type_reducer.dart';

class ActionFragment extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ActionFragment> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {
  final Map<String, Tab> map = Map();

  TabController _controller;
  var _tags = ['将来', '本周', '周末', '今日', '明日'];
  int mValue = 0;

  @override
  void initState() {
    super.initState();
    print('Action iniState');
    _init();
    _controller = TabController(length: map.length, vsync: this);
  }

  @override
  bool get wantKeepAlive => true;



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
        bottom: TabBar(
            isScrollable: true,
            controller: _controller,
            indicatorColor: AppColors.color_ff9900,
            labelColor: AppColors.color_ff9900,
            labelStyle:
                const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.black38,
            unselectedLabelStyle: const TextStyle(fontSize: 12.0),
            tabs: _buildTabs()),
        actions: <Widget>[_renderPopMenu()],
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
                   if(selected){
                     setState(() {
                       mValue = selected ? index : null;
                       switch (index) {
                         case 0:
                           StoreProvider.of<GlobalState>(context).dispatch(UpdateActionDateTypeAction('future'));
                           break;
                         case 1:
                           StoreProvider.of<GlobalState>(context).dispatch(UpdateActionDateTypeAction('week'));
                           break;
                         case 2:
                           StoreProvider.of<GlobalState>(context).dispatch(UpdateActionDateTypeAction('weekend'));
                           break;
                         case 3:
                           StoreProvider.of<GlobalState>(context).dispatch(UpdateActionDateTypeAction('today'));
                           break;
                         case 4:
                           StoreProvider.of<GlobalState>(context).dispatch(UpdateActionDateTypeAction('tomorrow'));
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
              children: _buildTabViews(),
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
      list.add(EventList(type: value,));
    });
    return list;
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
            QrScanUtil.scan();
            break;
          case 1:
            RouteUtil.pushByNamed(context, RouteConfig.cityName);
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
              child: StoreConnector<GlobalState, City>(
                converter: (store) => store.state.city,
                builder: (context, city) {
                  return Row(
                    children: <Widget>[
                      Icon(Icons.location_city),
                      Text(city.name)
                    ],
                  );
                },
              ),
            ),
          ],
    );
  }




}
