import 'package:flutter/material.dart';
import 'package:Inke/http/api.dart';
import 'dart:async';
import 'package:Inke/bean/action_result_entity.dart';
import 'package:Inke/util/event_util.dart';
import 'package:provider/provider.dart';
import 'package:Inke/event/event_scroll_top.dart';
import 'package:Inke/provider/city_provider.dart';
import 'package:Inke/config/route_config.dart';
import 'package:Inke/util/image_util.dart';
import 'package:Inke/widgets/future_builder.dart';


class ActionList extends StatefulWidget {

  final String type;
  final String dateType;

  ActionList({Key key, @required this.type,@required this.dateType}) : super(key: key);

  @override
  State createState() => _State();
}

class _State extends State<ActionList> with AutomaticKeepAliveClientMixin {
  ScrollController _controller = ScrollController();
  StreamSubscription mSubscription;
  var _cityId;
  var _dateType = '';
  List<ActionResultEvent> dataList;
  @override
  void initState() {
    super.initState();
    mSubscription = EventUtil.getInstance().getEventBus().on<ScrollTopEvent>().listen((event) {
      if (_controller.hasClients) {
        //_controller.jumpTo(10.0);
        _controller.animateTo(0.0,duration: Duration(milliseconds: 500),curve: Curves.ease);
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
    return Consumer<CityProvider>(
      builder: (context, CityProvider provider,_) {
        if (_cityId == provider.id &&
            _dateType == widget.dateType &&
            dataList != null) {
          return _buildList();
        } else {
          _cityId = provider.id;
          _dateType = widget.dateType;
          return FutureContainer<ActionResultEntity>(
            future: Api.getActionList(_cityId, _dateType, widget.type),
            dataWidget: (ActionResultEntity data){
              dataList = data.events;
              return _buildList();
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
          RouteUtil.pushNamedByArgs(context, RouteName.webName,
              {'title': event.title, 'url': event.adaptUrl});
        },
      ),
    );
  }
}