import 'package:Inke/provider/city_provider.dart';
import 'package:Inke/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:Inke/config/app_config.dart';
import 'package:Inke/util/route_util.dart';
import 'package:Inke/config/route_config.dart';
import 'package:Inke/event/event_scroll_top.dart';
import 'package:Inke/util/event_util.dart';
import 'package:provider/provider.dart';
import 'package:Inke/provider/date_type_provider.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/http/api.dart';
import 'dart:async';
import 'package:Inke/widgets/loading_view.dart';
import 'package:Inke/bean/action_result_entity.dart';
import 'package:Inke/http/http_manager.dart';
import 'package:Inke/widgets/widget_refresh.dart';

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
  var test = '所有';
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
                            Provider.of<DateTypeProvider>(context)
                                .setType('future');
                            break;
                          case 1:
                            Provider.of<DateTypeProvider>(context)
                                .setType('week');
                            break;
                          case 2:
                            Provider.of<DateTypeProvider>(context)
                                .setType('weekend');
                            break;
                          case 3:
                            Provider.of<DateTypeProvider>(context)
                                .setType('today');
                            break;
                          case 4:
                            Provider.of<DateTypeProvider>(context)
                                .setType('tomorrow');
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
                  (index) => EventList(type: tabs.keys.toList()[index])),
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
            RouteUtil.pushByNamed(context, RouteConfig.cityName);
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: <Widget>[Icon(Icons.scanner), SizedBox(width: 10,),Text('扫一扫')],
          ),
        ),
        PopupMenuDivider(height: 1.0,),
        PopupMenuItem<int>(
          value: 1,
          child: Consumer<CityProvider>(
            builder: (context, CityProvider provider, _) {
              return Row(
                children: <Widget>[
                  Icon(Icons.location_city),
                  SizedBox(width: 10,),
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

class EventList extends StatefulWidget {
  final String type;

  EventList({Key key, @required this.type}) : super(key: key);

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<EventList> with AutomaticKeepAliveClientMixin {
  ScrollController _controller = ScrollController();
  StreamSubscription mSubscription;
  var _cityId;
  var _dateType;
  List<ActionResultEvent> dataList;

  @override
  void initState() {
    super.initState();
    mSubscription = EventUtil.getInstance().getEventBus().on().listen((event) {
      if (event.runtimeType == ScrollTopEvent) {
        if (_controller.hasClients) {
          _controller.jumpTo(10.0);
        }
      }
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    mSubscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<ActionResultEntity> _requestAction(cityId, dateType) async {
    var response = await HttpManager.getInstance().get(ApiService.GET_EVENTS,
        params: {'loc': cityId, 'day_type': dateType, 'type': widget.type});
    return ActionResultEntity.fromJson(response);
  }

  Future<void> _onRefresh() async {
    setState(() {
      _cityId = null;
      _dateType = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildBody();
  }

  _buildBody() {
    return Consumer2<CityProvider, DateTypeProvider>(
      builder: (context, CityProvider provider, DateTypeProvider dateType, _) {
        if (_cityId == provider.id &&
            _dateType == dateType.dateType &&
            dataList != null) {
          return _buildList();
        } else {
          _cityId = provider.id;
          _dateType = dateType.dateType;
          return FutureBuilder<ActionResultEntity>(
            future: _requestAction(_cityId, _dateType),
            builder: (BuildContext context,
                AsyncSnapshot<ActionResultEntity> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return LoadingView();
                  break;
                default:
                  if (snapshot.hasError) {
                    return RefreshWidget(
                      callback: () {
                        setState(() {
                          _cityId = null;
                          _dateType = null;
                        });
                      },
                    );
                  } else {
                    dataList = snapshot.data.events;
                    return _buildList();
                  }
              }
            },
          );
        }
      },
    );
  }

  Widget _buildList() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
          itemCount: dataList.length,
          controller: _controller,
          itemBuilder: (context, position) => _buildItems(dataList[position])),
    );
  }

  _buildItems(ActionResultEvent event) {
    var icon = loadNetworkImage(event.image, width: 100.0, height: 120.0);
    var info = Container(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            event.title,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0),
            softWrap: true,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              '地点:${event.locName}',
              style: const TextStyle(fontSize: 14.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              '地址:${event.address}',
              style:
                  const TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              event.priceRange,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.red),
              softWrap: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text('是否含门票:${event.hasTicket == false ? '否' : '是'}'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text('开始时间:${event.beginTime}'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text('结束时间:${event.endTime}'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text('已参与人数:${event.participantCount}'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text('想参加人数:${event.wisherCount}'),
          ),
        ],
      ),
    );
    var item = Container(
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
      child: Row(
        children: <Widget>[
          icon,
          Expanded(
            child: info,
          ),
        ],
      ),
    );
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(7.0),
      elevation: 10.0,
      child: InkWell(
        child: item,
        onTap: () {
          RouteUtil.pushNamedByArgs(context, RouteConfig.webName,
              {'title': event.title, 'url': event.adaptUrl});
        },
      ),
    );
  }
}
