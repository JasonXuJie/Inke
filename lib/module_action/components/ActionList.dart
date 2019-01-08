import 'package:flutter/material.dart';
import '../../util/SharedUtil.dart';
import '../../Api.dart';
import '../../bean/event.dart';
import '../../page/Web.dart';
import 'dart:async';
import '../../util/DioUtil.dart';
import 'package:event_bus/event_bus.dart';
import '../../event/CityChangedEvent.dart';
import '../../util/EventUtil.dart';
import '../../components/LoadingView.dart';
import '../../util/JumpUtil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../config/AppConfig.dart';


class EventList extends StatefulWidget {
  String tag;

  EventList(this.tag);

  @override
  _State createState() => _State();
}

class _State extends State<EventList> {
  List<Events> events = [];
  EventBus eventBus = EventBus();
  StreamSubscription cityChangedSubscription;

  @override
  void initState() {
    super.initState();
    _requestActions(widget.tag);
    cityChangedSubscription =
        EventUtil.getInstance().eventBus.on<CityChangedEvent>().listen((event) {
      _requestActions(widget.tag);
    });
  }

  @override
  void dispose() {
    cityChangedSubscription.cancel();
    super.dispose();
  }

  _requestActions(type, {locId = '108296'}) async {
    var id = SharedUtil.getInstance().getCity()[SharedUtil.CITY_ID];
    if (id != null) locId = id;
    var response = await DioUtil.getInstance().get(ApiService.GET_EVENTS,
        data: {'loc': locId, 'day_type': 'future', 'type': type});
    var json = event.fromJson(response);
    setState(() {
      events = json.events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: getBody());
  }

  getBody() {
    if (events.length != 0) {
      return RefreshIndicator(
          child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context,position)=>_buildItems(events[position])
          ),
          onRefresh: _refreshData);
    } else {
      return Center(child: LoadingView());
    }
  }

  Future<Null> _refreshData() async {
    _requestActions(widget.tag);
    return null;
  }

  _buildItems(Events event) {
    var icon = CachedNetworkImage(
        imageUrl: event.image,
        width: 100.0,
        height: 120.0,
        fit: BoxFit.cover,
        placeholder: Image.asset(AppImgPath.mainPath+'img_loading.jpeg',width: 100.0,height: 120.0,),
        errorWidget: Image.asset(AppImgPath.mainPath+'img_loading_error.png',width: 100.0,height: 120.0,),
    );
    var info = Container(
      padding: EdgeInsets.only(left: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            event.title,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0),
            softWrap: true,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              '地点:${event.locName}',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              '地址:${event.address}',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              event.priceRange,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.red),
              softWrap: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text('是否含门票:${event.hasTicket == false ? '否' : '是'}'),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text('开始时间:${event.beginTime}'),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text('结束时间:${event.endTime}'),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text('已参与人数:${event.participantCount}'),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text('想参加人数:${event.wisherCount}'),
          ),
        ],
      ),
    );
    var item = Container(
      padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
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
      margin: EdgeInsets.all(7.0),
      elevation: 10.0,
      child: InkWell(
        child: item,
        onTap: () {
          JumpUtil.push(context, Web(title: event.title, url: event.adaptUrl));
        },
      ),
    );
  }
}
